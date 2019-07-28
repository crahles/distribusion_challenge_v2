# frozen_string_literal: true

class Terminal
  attr_reader :connection

  def self.open(*args)
    new(*args)
  end

  def initialize(connection)
    @connection = connection
  end

  def start_tracer_for(source)
    data = connection.routes_for(source)
    locations = SourceExtractor.for(source).with(data)
    connection.import_locations(source, locations)
  end
end
