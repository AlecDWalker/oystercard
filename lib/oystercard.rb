# frozen_string_literal: true

require 'journey'

class Oystercard
  DEAFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :entry_station, :history, :balance

  def initialize(balance: DEAFAULT_BALANCE, journey: Journey.new)
    @balance = balance
    @history = []
    @journey = journey
  end

  def in_journey?; end

  def touch_in(entry_station)
    penalty_charge if journey.already_touched_in?

    raise 'Insufficient funds' if insufficient?

    journey.touch_in(entry_station)
  end

  def touch_out(exit_station)
    journey.touch_out(exit_station)
    deduct(journey.fare)
    @history << journey
    'Charged penalty fare for not touching in' if history.last.incomplete?
  end

  def top_up(amount)
    raise "Exceeds £#{MAXIMUM_BALANCE} maximum limit" if over_max?(amount)

    @balance += amount
  end

  private

  def penalty_charge
    deduct(journey.fare)
    @history << journey
    'Charged penalty fare for not touching out'
  end

  def over_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

  def insufficient?
    @balance < MINIMUM_FARE
  end
end
