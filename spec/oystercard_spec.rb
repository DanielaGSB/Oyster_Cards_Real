require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:station)  { double(:station)    }

  fare      = -described_class::FARE
  max_limit = described_class::MAX_LIMIT

  describe '#balance' do
    it 'has a balance of 0' do
      expect(card.balance).to eq 0
    end
    it 'raises error if card balance is below fare' do
      expect{ card.touch_in(station) }.to raise_error"Sorry mate- you need a top up!"
    end
  end

  context 'tests that require a topped up card' do

    before do
      card.top_up(max_limit)
    end

    describe '#top_up' do
      it 'can be topped up' do
        expect(card.balance).to eq max_limit
      end
      it 'raises error when max limit is exceeded' do
        expect{ card.top_up(1) }.to raise_error "Sorry mate- Limit is #{max_limit}"
      end
    end

    describe '#touch_out' do
      it 'checks if card.in_journey? returns false upon touch_out' do
        card.touch_in(station)
        expect{ card.touch_out(station) }.to change{ card.in_journey? }.to eq false
      end
      it 'subtracts FARE from balance' do
        card.touch_in(station)
        expect{ card.touch_out(station) }.to change{ card.balance }.by fare
      end
      it 'current_trip resets upon touch_out' do
        card.touch_in(station)
        expect{ card.touch_out(station) }.to change{ card.journeys.current_journey }.to eq []
      end
    end

    describe '#touch_in' do
      it 'changes journey_in attribute to true' do
        expect{ card.touch_in(station) }.to change{ card.in_journey? }.to eq true
      end
      it 'should record station on touch_in' do
        card.touch_in(station)
        expect(card.journeys.current_journey).to eq [station]
      end
    end

    describe '#current_trip' do
      before do
        card.touch_in(station)
        card.touch_out(station)
      end
      it 'current_trip is cleared upon touch_out' do
        expect(card.journeys.current_journey).to eq []
      end
      it 'logs current_trip after touch_in and touch_out' do
        expect(card.journeys.all_journeys.length).to eq 1
      end
    end

  end

end
