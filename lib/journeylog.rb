# should record a journey history

require './lib/oystercard.rb'
#
class Journeylog

  attr_reader :journey, :history

  def initialize(journey = Journey)
    @journey_klass = journey
    @history = []
  end

  def start(station)
    @journey = @journey_klass.new
    @journey.entry_station(station)
  end

  def end(station)
    @journey.exit_station(station)
    @history << journey
  end




end
