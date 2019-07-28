# frozen_string_literal: true

require_relative 'loopholes_source'
require_relative 'sentinels_source'
require_relative 'sniffers_source'

class SourceExtractor
  def self.for(source)
    case source
    when 'sentinels'
      SentinelsSource.new
    when 'sniffers'
      SniffersSource.new
    when 'loopholes'
      LoopholesSource.new
    else
      raise 'unsupported source'
    end
  end
end
