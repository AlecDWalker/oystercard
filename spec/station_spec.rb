require 'station'
describe Station do
let(:station) {Station.new('name', 'zone')}

it 'records station name' do
  expect(station.name).to eq 'name'
end

it 'records station zone' do
  expect(station.zone).to eq 'zone'
end

end
