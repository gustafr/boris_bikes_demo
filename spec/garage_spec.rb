require 'garage'
require 'bike_container_spec'

describe Garage do
  it_should_behave_like 'BikeContainer'
  let (:broken_bike){double :bike}
  let (:broken_bike_2){double :bike}
  let (:garage){Garage.new}

  it 'should be able to command broken bikes to be fixed' do
    expect(broken_bike).to receive(:fix!)
    garage.load(broken_bike)
    garage.repair!
    end 

  it 'should repair all the bikes' do
    expect(broken_bike).to receive(:fix!)
    expect(broken_bike_2).to receive(:fix!)
    garage.load(broken_bike)
    garage.load(broken_bike_2)
    garage.repair!
  end

end