require './lib/journey.rb'

class Oystercard
  MAX_LIMIT = 90
  FARE = 1

  attr_reader :balance, :journeys

  def initialize
    @balance = 0
    @journeys = Journey.new
  end

  def top_up(amount)
    raise "Sorry mate- Limit is #{MAX_LIMIT}" if maxed_out(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Sorry mate- you need a top up!" if out_of_cash?
    pay_fine
    self.journeys.start(entry_station)
  end

  def touch_out(exit_station)
    self.journeys.end(exit_station)
    charge_card
    self.journeys.store_journey
    @balance
  end

  def in_journey?
    !self.journeys.current_journey.empty?
  end

  private

  def charge_card
    @balance -= self.journeys.charge
  end

  def pay_fine
    unless self.journeys.current_journey.empty?
      @balance -= self.journeys.charge
    end
  end

  def maxed_out(amount)
    @balance + amount > MAX_LIMIT
  end

  def out_of_cash?
    FARE > @balance
  end

end
