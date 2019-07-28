# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength
describe SniffersSource do
  describe '#extract_locations' do
    it 'returns an array of valid locations' do
      data = OpenStruct.new
      data.body = File.read('spec/data/sniffers.zip')
      items = described_class.new.send(:unzipped, data)
      locations = described_class.new.extract_locations(items)
      expect(locations).to eq(
        [
          BaseSource::Location.new(
            'tau', 'psi', '2030-12-31T13:00:07', '2030-12-31T13:00:08'
          ),
          BaseSource::Location.new(
            'psi', 'omega', '2030-12-31T13:00:07', '2030-12-31T13:00:08'
          ),
          BaseSource::Location.new(
            'lambda', 'psi', '2030-12-31T13:00:07', '2030-12-31T13:00:08'
          ),
          BaseSource::Location.new(
            'lambda', 'psi', '2030-12-31T13:00:00', '2030-12-31T13:00:01'
          )
        ]
      )
    end
  end
end
# rubocop:enable RSpec/ExampleLength
