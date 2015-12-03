require './lib/oystercard.rb'

class Journey
  MIN_FARE = 1
  FINE = 6

attr_reader :current_journey

  def initialize
    @current_journey = []

  end

  def entry_station(station)
    if @current_journey.empty?
      @current_journey << station
    else
      self.charge
      @current_journey = [station]
    end
  end

  def exit_station(station)
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

private


  def incomplete_journey
    if @current_journey.length < 2
      FINE
    end
  end


end
