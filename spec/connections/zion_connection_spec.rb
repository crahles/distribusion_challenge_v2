# frozen_string_literal: true

describe ZionConnection do
  let(:passphrase) { FFaker::Lorem.characters(23) }

  describe '#initialize' do
    it 'takes a passphrase on construction' do
      connection = described_class.new(passphrase)
      expect(connection.passphrase).to be(passphrase)
    end

    context 'when a logger is specified' do
      it 'uses that logger' do
        logger = double
        connection = described_class.new(passphrase, logger)
        expect(connection.logger).to be(logger)
      end
    end

    context 'when a logger is not specified' do
      it 'disables logging' do
        connection = described_class.new(passphrase)
        expect(connection.logger).to be(nil)
      end
    end
  end

  describe '#routes_for(source)' do
    let(:source) { FFaker::Lorem.word }
    let(:request_url) do
      "#{described_class::ROUTES_URL}?passphrase=#{passphrase}&source=#{source}"
    end

    it 'gets the requests route info' do
      mock_request(:get, request_url, nil, 'test')
      connection = described_class.new(passphrase)
      response = connection.routes_for(source)
      expect(response.body).to eq('test')
    end
  end

  describe '#import_locations' do
    let(:source) { FFaker::Lorem.word }
    let(:locations) { [FactoryBot.build(:location)] }
    let(:request_url)  { described_class::ROUTES_URL }
    let(:request_body) do
      URI.encode_www_form(
        {
          passphrase: passphrase,
          source: source
        }.merge(locations[0].to_h)
      )
    end

    it 'imports the routes to zion mainframe' do
      mock_request(:post, request_url, request_body)
      connection = described_class.new(passphrase)
      connection.import_locations(source, locations)
    end
  end

  def mock_request(
    verb,
    request_url,
    request_body = nil,
    response_body = '',
    response_code = 200
  )
    stub_request(verb.to_sym, request_url)
      .with(
        body: request_body,
        headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' }
      )
      .to_return(status: response_code, body: response_body, headers: {})
  end
end
