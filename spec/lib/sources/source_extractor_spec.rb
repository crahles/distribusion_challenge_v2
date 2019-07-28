# frozen_string_literal: true

describe SourceExtractor do
  describe '.for' do
    expected_values = {
      'sentinels' => SentinelsSource,
      'loopholes' => LoopholesSource,
      'sniffers' => SniffersSource
    }
    expected_values.each do |val, expected|
      it "returns #{expected} when source is #{val}" do
        expect(described_class.for(val)).to be_instance_of(expected)
      end
    end

    it 'returns an error if source is unknown' do
      expect do
        described_class.for('dummy')
      end.to raise_error(RuntimeError, 'unsupported source')
    end
  end
end
