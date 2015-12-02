require 'journey'

describe Journey do
  let(:journey) { described_class.new }
  let (:station) { double(:station) }

describe '#start' do
    it 'adds start station to current journey' do
      journey.start(station)
      expect(journey.current_journey).to eq [station]
    end

    it 'resets journey when previous journey incomplete' do
      journey.start(station)
      journey.start(station)
      expect(journey.current_journey).to eq [station]
    end

end

describe '#end' do
    it 'adds the end station to current journey' do
      journey.start(station)
      journey.end(station)
      expect(journey.current_journey).to eq [station,station]
    end
    it 'charges fine if no start station' do
      expect(journey.end(station)).to eq Journey::FINE
    end
  end


describe '#charge' do
  it 'charges min fare if journey is complete' do
    journey.start(station)
    journey.end(station)
    expect(journey.charge).to eq Journey::MIN_FARE
  end
  it 'charges fine if journey is incomplete - no exit station' do
    journey.start(station)
    expect(journey.charge).to eq Journey::FINE
  end
  it 'charges fine if journey is incomplete - no entry station' do
    journey.end(station)
    expect(journey.charge).to eq Journey::FINE
  end
end

describe '#store_journey' do
  it 'ensures journey is saved in all journeys' do
    journey.start(station)
    journey.end(station)
    journey.store_journey
    expect(journey.all_journeys[1]).to eq [station, station]
  end
  it 'resets current journey upon completion' do
    journey.start(station)
    journey.end(station)
    journey.store_journey
    expect(journey.current_journey).to eq []
  end
end
end
