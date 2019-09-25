class Journey
  def touch_in(station)
    @in_journey = true
  end

  def touch_out(station)
    @in_jounrey = false
  end

  def in_journey?
    @in_journey
  end
end
