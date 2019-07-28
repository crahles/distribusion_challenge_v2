# frozen_string_literal: true

require 'zip'
class BaseSource
  Location = Struct.new(:start_node, :end_node, :start_time, :end_time)

  def with(data)
    raise NotImplementedError unless respond_to?(:extract_locations)

    extract_locations(unzipped(data))
  end

  private

  def unzipped(data)
    items = {}

    ::Zip::File.open_buffer(data.body) do |zip|
      zip.each do |entry|
        next unless entry.ftype == :file && !entry.name.include?('__MACOSX')

        filename = entry.name
        content = entry.get_input_stream.read
        items[filename] = parse_content(filename, content)
      end
    end

    items
  end

  def parse_content(filename, content)
    case File.extname(filename)
    when '.csv'
      CSV.parse(
        content,
        headers: :first_row, converters: :numeric, col_sep: ', '
      ).map(&:to_hash)
    when '.json'
      Oj.load(content, mode: :compat, object_class: OpenStruct)
    end
  end

  def isotime(date_time)
    DateTime.parse(date_time).to_time.utc.strftime('%Y-%m-%dT%H:%M:%S').to_s
  end
end
