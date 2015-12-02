require 'journey'

describe Journey do
  let(:journey) { described_class.new }
    it 'creates a new journey' do
      expect(journey).to respond_to(:start)
    end

    it 'ends a new journey' do
      expect(journey).to respond_to(:end)
    end

    it 'expects to calculate far of journey' do
      expect(journey).to respond_to(:fare)
    end
end
