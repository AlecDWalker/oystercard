class Journey
  MINIMUM_FARE = 1
  def touch_in(entry_station)
    @in_journey = true
  end

  def touch_out(exit_station)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def fare
    MINIMUM_FARE
  end
end
