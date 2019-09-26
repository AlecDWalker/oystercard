# frozen_string_literal: true

require 'journey'

describe Journey do
  let(:station) { double('Station') }
  let(:min_fare) { Journey::MINIMUM_FARE }
  let(:penalty_fare) { Journey::PENALTY_FARE }

  describe '#initialize' do
    it 'initiliazes with a nil entry and exit station' do
      expect(subject.entry_station).to eq nil
      expect(subject.exit_station).to eq nil
    end
    it 'initiliazes not in a journey' do
      expect(subject.in_journey).to eq false
    end
  end

  describe '#touch in' do
    it 'records the entry station on touch in' do
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#touch out' do
    it 'records the exit station on touch out' do
      subject.touch_out(station)
      expect(subject.exit_station).to eq station
    end
  end

  describe '#fare' do
    it 'returns a normal fare on a standard journey' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.fare).to eq min_fare
    end
    it 'returns a penalty fare if journey is incomplete' do
      subject.touch_out(station)
      expect(subject.fare).to eq penalty_fare
    end
  end

  describe '#already_touched_in' do
    it 'checkes if already touched in' do
      subject.touch_in(station)
      expect(subject.entry_station).not_to eq nil
    end
  end
  # when touch in
  # -record an entry station
  # - raise an error and charge penalty if already in journey

  # when touch out
  # - recrord an exit station
  # - raise an error if touched out twice

  # fare
  # calculate a fare normal or penalty
end
