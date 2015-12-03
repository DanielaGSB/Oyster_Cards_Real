require 'journey'

describe Journey do
  let(:journey) { described_class.new }
  let(:station) { double(:station) }

describe '#entry_station' do
    it 'adds start station to current journey' do
      journey.entry_station(station)
      expect(journey.current_journey).to eq [station]
    end

    it 'resets journey when previous journey incomplete' do
      journey.entry_station(station)
      journey.entry_station(station)
      expect(journey.current_journey).to eq [station]
    end

end

describe '#end' do
    it 'adds the end station to current journey' do
      journey.entry_station(station)
      journey.end(station)
      expect(journey.current_journey).to eq [station,station]
    end
    it 'charges fine if no start station' do
      expect(journey.end(station)).to eq Journey::FINE
    end
    
  end


describe '#charge' do
  it 'charges min fare if journey is complete' do
    journey.entry_station(station)
    journey.end(station)
    expect(journey.charge).to eq Journey::MIN_FARE
  end
  it 'charges fine if journey is incomplete - no exit station' do
    journey.entry_station(station)
    expect(journey.charge).to eq Journey::FINE
  end
  it 'charges fine if journey is incomplete - no entry station' do
    journey.end(station)
    expect(journey.charge).to eq Journey::FINE
  end
end



end
