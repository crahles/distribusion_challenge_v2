# frozen_string_literal: true

require_relative 'base_source'
class LoopholesSource < BaseSource
  def extract_locations(items)
    node_pairs = items['loopholes/node_pairs.json'].node_pairs
    routes = items['loopholes/routes.json'].routes

    routes.map do |route|
      node_pair = node_pairs[route.node_pair_id.to_i]
      next unless node_pair

      Location.new(
        node_pair.start_node,
        node_pair.end_node,
        isotime(route.start_time),
        isotime(route.end_time)
      )
    end.compact
  end
end
