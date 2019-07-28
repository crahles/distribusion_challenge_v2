# frozen_string_literal: true

class ZionConnection
  ROUTES_URL = 'https://challenge.distribusion.com/the_one/routes'
  attr_reader :passphrase, :logger

  def initialize(passphrase, logger = nil)
    @passphrase = passphrase
    @logger = logger
  end

  def routes_for(source)
    HTTParty.get(ROUTES_URL, query: {
                   'passphrase' => passphrase,
                   'source' => source
                 }, debug_output: logger)
  end

  def import_locations(source, locations)
    locations.each do |location|
      response = HTTParty.post(ROUTES_URL,
                               body: {
                                 passphrase: passphrase,
                                 source: source
                               }.merge(location.to_h),
                               debug_output: logger)

      puts response.body.force_encoding('UTF-8')
    end
  end
end
