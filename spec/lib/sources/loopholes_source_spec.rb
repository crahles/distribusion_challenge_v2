# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength
describe LoopholesSource do
  describe '#extract_locations' do
    it 'returns an array of valid locations' do
      data = OpenStruct.new
      data.body = File.read('spec/data/loopholes.zip')
      items = described_class.new.send(:unzipped, data)
      locations = described_class.new.extract_locations(items)
      expect(locations).to eq(
        [
          BaseSource::Location.new(
            'beta', 'theta', '2030-12-31T13:00:04', '2030-12-31T13:00:05'
          ),
          BaseSource::Location.new(
            'theta', 'lambda', '2030-12-31T13:00:05', '2030-12-31T13:00:06'
          )
        ]
      )
    end
  end
end
# rubocop:enable RSpec/ExampleLength
