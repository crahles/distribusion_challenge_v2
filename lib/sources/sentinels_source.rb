# frozen_string_literal: true

require_relative 'base_source'
class SentinelsSource < BaseSource
  def extract_locations(items)
    routes = items['sentinels/routes.csv']

    routes.map do |route|
      next unless node_available route['node']

      Location.new(
        route['node'],
        route['node'],
        isotime(route['time']),
        isotime(route['time'])
      )
    end.compact
  end

  def node_available(node)
    %w[alpha beta gamma delta theta lambda tau psi omega].include? node
  end
end
