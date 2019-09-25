require 'journey'

class Oystercard

DEAFAULT_BALANCE = 0
MAXIMUM_BALANCE = 90

attr_accessor :balance
attr_reader :maximum , :entry_station , :history

  def initialize(balance: DEAFAULT_BALANCE, journey: Journey.new)
    @balance = balance
    @maximum = MAXIMUM_BALANCE
    @entry_station = nil
    @history = []
    @journey = journey
    @minimum_fare = Journey::MINIMUM_FARE
  end

  def in_journey?
    @journey.in_journey?
  end

  def touch_in(entry_station)
    fail 'Insufficient funds' if @balance < @minimum_fare
    @journey.touch_in(entry_station)
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @journey.touch_out(exit_station)
    deduct(@journey.fare)
    @history << {in: entry_station , out: exit_station}
    @entry_station = nil
  end

  def top_up(amount)
    fail "Exceeds £#{maximum} maximum limit" if over_max?(amount)
    @balance += amount
  end

  private

  def over_max?(amount)
    @balance + amount > @maximum
  end

  def deduct(amount)
    @balance -= amount
  end

end
