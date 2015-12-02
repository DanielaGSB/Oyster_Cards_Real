require './lib/oystercard.rb'

class Journey
  MIN_FARE = 1
  FINE = 6

attr_reader :current_journey

  def initialize
    @current_journey = []
    @all_journeys = {}
  end

  def start(station)
    if @current_journey.empty?
      @current_journey << station
    else
      self.charge
      @current_journey = [station]
    end
  end

  def end(station)
    if @current_journey.empty?
      incomplete_journey
    else
      @current_journey << station
    end
  end

  def charge
    if @current_journey.length == 2
      MIN_FARE
    else
      incomplete_journey
    end
  end

  def store_journey
    @all_journeys[@all_journeys.length + 1] = @current_journey
    @current_journey = []
  end

private


  def incomplete_journey
    if @current_journey.length < 2
      FINE
    end
  end


end
