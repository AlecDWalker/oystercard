class Oystercard

DEAFAULT_BALANCE = 0
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1

attr_accessor :balance
attr_reader :maximum , :active , :entry_station , :history

  def initialize(balance= DEAFAULT_BALANCE)
    @balance = balance
    @maximum = MAXIMUM_BALANCE
    @active = false
    @entry_station = nil
    @history = []
  end

  def in_journey?
  !!entry_station
  end

  def touch_in(entry_station)
    fail 'Insufficient funds' if @balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
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
