require 'journey'

describe Journey do
  let(:station) { double("Station") }
  describe '#touch_in' do
    context 'when not touched in' do
      it 'returns true' do
        expect(subject.touch_in(station)).to eq true
      end
    end
      context 'when touched in' do
      it 'raises error on double touch in' do
        subject.touch_in(station)
        expect(subject.in_journey?).to be true
        expect{subject.touch_in(station)}.to raise_error 'Penalty incurred: touched in twice'
      end
    end
  end

  describe '#touch_out' do
    context 'when touched in' do
      it 'returns false' do
        subject.touch_in(station)
        expect(subject.touch_out(station)).to eq false
      end
    end
    context 'when touched out' do
      it 'raises an error when touched out twice' do
        expect{subject.touch_out(station)}.to raise_error 'Penalty incurred: touched out twice'
      end
    end
  end

  describe '#in_journey?' do
    context 'when in a journey' do
      it 'returns true' do
        subject.touch_in(station)
        expect(subject.in_journey?).to eq true
      end
    end
    context 'when not in a journey' do
      it 'returns false' do
        expect(subject).to_not be_in_journey
      end
    end
  end

  describe '#fare' do
    context 'on trip completion' do
      it 'returns the minimum fare' do
        expect(subject.fare).to eq Journey::MINIMUM_FARE
      end
    end

    context 'when penalty incurred' do
      it 'returns Penalty Fare when double touched out' do
        subject.touch_out(station)
        expect(subject.fare).to eq Journey::PENALTY_FARE
      end
      it 'returns Penalty Fare when double touched in' do
        subject.touch_in(station)
        subject.touch_in(station)
        expect(subject.fare).to eq Journey::PENALTY_FARE
      end
    end
  end
end
