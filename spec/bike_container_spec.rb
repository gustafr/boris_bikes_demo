require_relative '../lib/bike_container'

class ContainerHolder
  include BikeContainer
end

shared_examples "BikeContainer" do
  
    let (:holder) {ContainerHolder.new}
    let (:bike) {double :bike}

    def load_bike_doubles_into_(holder)
      working_bike = double :bike, broken?: false
      broken_bike = double :bike, broken?: true
      holder.load(working_bike)
      holder.load(broken_bike)
    end
  context 'General Functions' do

    it 'should start with no bikes' do
      expect(holder.bike_count).to eq 0
    end

    it 'should load a bike' do  
      holder.load(bike)
      expect(holder.bike_count).to eq 1
    end

    it "should know when it's full" do
      expect(holder).not_to be_full
      10.times { holder.load(bike) }
      expect(holder).to be_full
    end

    it "should know when it is not full" do
      expect(holder).not_to be_full
      9.times { holder.load(bike) }
      expect(holder).not_to be_full
    end

    it 'should return an error if load is called on a full container' do
    11.times{holder.load(bike)}
    expect(holder.load(bike)).to eq 'Full!'
    end

  end

  context 'Working bikes' do

    it 'should offload a functioning bike' do
      load_bike_doubles_into_(holder)
      holder.offload_functioning_bike
      expect(holder.bike_count).to eq(1)
    end

    it 'should provide the list of functioning bikes' do
      load_bike_doubles_into_(holder)
      expect(holder.functioning_bikes.count).to eq 1
    end

    it 'can return an array containing only working bikes' do
      load_bike_doubles_into_(holder)
      expect(holder.functioning_bikes.count).to eq 1
    end

    it 'knows if it is possible to get another working bike' do
      giver = holder
      taker = holder
      load_bike_doubles_into_(giver)
      expect(taker.should_collect_functioning_bikes?(giver)).to be true
    end

    it 'knows if it is not possible to get another working bike' do
      giver = holder
      taker = holder
      expect(taker.should_collect_functioning_bikes?(giver)).to be false
    end

    it 'should get a working bike from another container' do
      # station = double :station, offload_broken_bike: broken_bike
      transferred_bike = holder.offload_functioning_bike
      holder.load(transferred_bike)
      expect(holder.bike_count).to eq 1
    end

    it 'should demand working bikes until it reaches capacity' do
      giver = holder
      taker = holder
      10.times {taker.load(bike)}
      taker.demand_functioning_bikes_from(giver)
      expect(taker.bike_count).to eq 10
    end

  end

  context 'Broken bikes' do
    it 'should offload a broken bike' do
      load_bike_doubles_into_(holder)
      holder.offload_broken_bike
      expect(holder.functioning_bikes.count).to eq 1
      expect(holder.broken_bikes.count).to eq 0
    end

    it 'should provide the list of broken bikes' do
      load_bike_doubles_into_(holder)
      expect(holder.broken_bikes.count).to eq 1
    end
    
    it 'can return an array containing only broken bikes' do
      load_bike_doubles_into_(holder)
      expect(holder.broken_bikes.count).to eq 1
    end
    
    it 'knows if it is possible to get another broken bike' do
      giver = holder
      taker = holder
      load_bike_doubles_into_(giver)
      expect(taker.should_collect_broken_bikes?(giver)).to be true
    end

    it 'knows if it is not possible to get another broken bike' do
      giver = holder
      taker = holder
      expect(taker.should_collect_broken_bikes?(giver)).to be false
    end

    it 'should get a broken bike from another container' do
      # station = double :station, offload_broken_bike: broken_bike
      transferred_bike = holder.offload_broken_bike
      holder.load(transferred_bike)
      expect(holder.bike_count).to eq 1
    end

    it 'should demand broken bikes until it reaches capacity' do
      giver = holder
      taker = holder
      10.times {taker.load(bike)}
      taker.demand_broken_bikes_from(giver)
      expect(taker.bike_count).to eq 10
    end
  end
end
