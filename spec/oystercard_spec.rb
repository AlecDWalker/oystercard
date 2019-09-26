require 'oystercard'

describe Oystercard do
  let(:station){double :station}
  let(:entry_station){double :station}
  let(:exit_station){double :station}
  let(:journey) { 
    double :journey,
    in_journey?: false,
    :touch_in => true,
    :touch_out => false,
    fare: Journey::MINIMUM_FARE
  }
  let(:oystercard) { described_class.new(journey: journey)}
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE }
  let(:minimum_fare) { Oystercard::MINIMUM_FARE }
  it {is_expected.to respond_to :in_journey?}


  describe '#initialize' do
    it 'initializes with a balance of 0 if no value is given by the user' do
    expect(oystercard.balance).to eq 0
    end
  end
 describe '#in_journey?' do
   it 'in_journey returns true' do
     oystercard.top_up(10)
     oystercard.touch_in(station)
     expect(journey).to receive(:in_journey?).and_return true
     expect(oystercard.in_journey?).to eq true
   end
   it 'in_journey returns false' do
     expect(journey).to receive(:in_journey?).and_return false
     expect(oystercard.in_journey?).to eq false
   end
 end
  describe '#touch_in' do
    it {is_expected.to respond_to :touch_in}
    it 'changes active status to true when it has been touched in' do
      oystercard.top_up(5)
      expect(oystercard.touch_in(station)).to eq station
    end

    it 'denies entry if balance is less than £1' do
    expect{ oystercard.touch_in(station) }.to raise_error 'Insufficient funds'
    end

    it 'can record the entry station after being touched in' do
      oystercard.top_up(10)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

  end
  describe '#touch_out' do
  it {is_expected.to respond_to :touch_out}

  it 'changes active status to false when it has been touched out' do
  expect(journey).to receive(:touch_out).and_return false
  oystercard.top_up(5)
  oystercard.touch_in(station)
  oystercard.touch_out(station)
  expect(oystercard.in_journey?).to be false
  end

  it 'deducts the fare on touch out' do
  oystercard.top_up(5)
  oystercard.touch_in(station)
  expect(journey).to receive(:fare) { minimum_fare }
  expect { oystercard.touch_out(station) }.to change { oystercard.balance}.by(-minimum_fare)
  end
end
describe '#history' do
  it 'initializes with an empty array of previous journeys' do
    expect(oystercard.history).to be_empty
  end
  it 'populates a journey hash within the history array on touch out' do
    oystercard.top_up(5)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.history).to eq [{in: entry_station , out: exit_station}]
  end
end
  describe '#top_up' do
    it 'increases the total balance with the amount inputted by the user' do
      expect { oystercard.top_up(1) }.to change { oystercard.balance }.by 1
    end

    it 'rasises an error if balance total exceeds maximum balance' do
      expect { oystercard.top_up(100) }.to raise_error("Exceeds £#{maximum_balance} maximum limit")
    end
  end
end
