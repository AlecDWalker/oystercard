# frozen_string_literal: true

class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :entry_station, :exit_station, :in_journey

  def initialize
    @entry_station = nil
    @exit_station = nil
    @in_journey = false
  end

  def touch_in(station)
    self.entry_station = station
  end

  def touch_out(station)
    self.exit_station = station
  end

  def fare
    return MINIMUM_FARE unless incomplete?

    PENALTY_FARE
  end

  def already_touched_in?
    entry_station != nil
  end

  private

  def incomplete?
    entry_station.nil? || exit_station.nil?
  end
  # def in_journey?
  #   @in_journey
  # end
end
