require 'journeylog'

describe Journeylog do
  let(:station) { double(:station) }
  let(:exit_station) { double(:exit_station) }
  # let(:journey) { double(:journey, entry_station: station, exit_station: station) }
  subject(:journeylog) { described_class.new }

  describe '#start' do
    it 'should create a new journey' do
      journeylog.start(station)
      expect(journeylog.journey).not_to eq nil
    end
  end

  describe '#store_journey' do
    it 'ensures journey is saved in all journeys' do
      journeylog.start(station)
      journeylog.end(station)
      expect(journeylog.history).to include journey
    end

  end
end
