# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength,Metrics/BlockLength
describe SentinelsSource do
  describe '#extract_locations' do
    it 'returns an array of valid locations' do
      data = OpenStruct.new
      data.body = File.read('spec/data/sentinels.zip')
      items = described_class.new.send(:unzipped, data)
      locations = described_class.new.extract_locations(items)
      expect(locations).to eq(
        [
          BaseSource::Location.new(
            'alpha', 'alpha', '2030-12-31T13:00:01', '2030-12-31T13:00:01'
          ),
          BaseSource::Location.new(
            'beta', 'beta', '2030-12-31T13:00:02', '2030-12-31T13:00:02'
          ),
          BaseSource::Location.new(
            'gamma', 'gamma', '2030-12-31T13:00:03', '2030-12-31T13:00:03'
          ),
          BaseSource::Location.new(
            'delta', 'delta', '2030-12-31T13:00:02', '2030-12-31T13:00:02'
          ),
          BaseSource::Location.new(
            'beta', 'beta', '2030-12-31T13:00:03', '2030-12-31T13:00:03'
          ),
          BaseSource::Location.new(
            'gamma', 'gamma', '2030-12-31T13:00:04', '2030-12-31T13:00:04'
          )
        ]
      )
    end
  end
end
# rubocop:enable RSpec/ExampleLength,Metrics/BlockLength
