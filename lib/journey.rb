class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  def touch_in(entry_station)
      begin
      if in_journey?
        raise 'Penalty incurred: touched in twice'
      else
        @in_journey = true
      end
    rescue
      @penalty = true
    end
  end

  def touch_out(exit_station)
    begin
    if !in_journey?
      raise 'Penalty incurred: touched out twice'
    else
      @in_journey = false
    end
  rescue
    @penalty = true
  end
  end

  def in_journey?
    @in_journey
  end

  def fare
    if @penalty == true
      @penalty = false
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end
end
