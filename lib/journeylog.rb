class Journeylog

  attr_reader :current_journey, :journey_class

  def initialize(journey_class:)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
  end

  def start(station)
    current_journey.touch_in(station)
  end

  def finish

  end

  def journeys
  end

private

  def current_journey
    @current_journey ||= journey_class.new
  end
  end
