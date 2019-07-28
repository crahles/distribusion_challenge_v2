# frozen_string_literal: true

require_relative 'base_source'
class SniffersSource < BaseSource
  def extract_locations(items)
    sequences = items['sniffers/sequences.csv']
    routes = items['sniffers/routes.csv']
    node_times = items['sniffers/node_times.csv']

    sequences.map do |sequence|
      route_id = sequence['route_id']
      route = routes[route_id]

      node_time_id = sequence['node_time_id']
      node_time = node_times[node_time_id]
      next unless node_time

      start_time, end_time = times(
        route['time'], route['time_zone'],
        node_time['duration_in_milliseconds']
      )

      Location.new(
        node_time['start_node'], node_time['end_node'], start_time, end_time
      )
    end.compact
  end

  private

  def times(time, zone, duration)
    start_time = DateTime.parse(time + zone).to_time.utc
    end_time = start_time + (duration / 1000)
    [isotime(start_time.to_s), isotime(end_time.to_s)]
  end
end
