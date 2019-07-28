# frozen_string_literal: true

describe Terminal do
  let(:connection) { double }

  describe '#open' do
    it 'configures the terminal with given connection' do
      expect(described_class).to receive(:new).with(connection)
      described_class.open(connection)
    end
  end

  # rubocop:disable RSpec/MultipleExpectations
  describe '#start_tracer_for(source)' do
    let(:source) { FFaker::Lorem.word }
    let(:fake_source) { double }
    let(:locations) { [FactoryBot.build(:location)] }

    it 'runs the source extraction/import process' do
      allow(SourceExtractor).to receive(:for).and_return(fake_source)
      allow(fake_source).to receive(:with).and_return(locations)

      expect(connection).to receive(:routes_for).with(source)
      expect(connection).to receive(:import_locations).with(source, locations)

      described_class.open(connection).start_tracer_for(source)
    end
  end
  # rubocop:enable RSpec/MultipleExpectations
end
