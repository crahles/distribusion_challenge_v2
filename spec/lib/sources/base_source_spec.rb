# frozen_string_literal: true

describe BaseSource do
  describe '#extract_locations' do
    it 'returns an NoMethodError' do
      expect do
        described_class.new.extract_locations
      end.to raise_error(NoMethodError)
    end
  end

  describe '#with(data)' do
    it 'returns an NotImplementedError' do
      expect do
        described_class.new.with('')
      end.to raise_error(NotImplementedError)
    end
  end

  describe '#unzipped(data)' do
    it 'returns items within the zip file' do
      data = OpenStruct.new
      data.body = File.read('spec/data/loopholes.zip')
      items = described_class.new.send(:unzipped, data)
      expect(items).to include(
        'loopholes/node_pairs.json', 'loopholes/routes.json'
      )
    end
  end

  describe '#parse_content(filename, content)' do
    it 'returns a hash from parsed csv file' do
      data = OpenStruct.new
      data.body = File.read('spec/data/sentinels.zip')
      items = described_class.new.send(:unzipped, data)
      expect(items['sentinels/routes.csv'][0]).to be_a(Hash)
    end

    it 'returns an OpenStruct from parsed json file' do
      data = OpenStruct.new
      data.body = File.read('spec/data/loopholes.zip')
      items = described_class.new.send(:unzipped, data)
      expect(items['loopholes/node_pairs.json']).to be_a(OpenStruct)
    end
  end

  describe '#isotime(datetime)' do
    let(:datetime) { DateTime.new(2030, 12, 31, 22, 0o0, 0o3, '+09:00') }

    it 'returns ISO 8601 UTC time as string ' do
      time = described_class.new.send(:isotime, datetime.to_s)
      expect(time).to eq('2030-12-31T13:00:03')
    end
  end
end
