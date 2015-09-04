module BikeContainer

  DEFAULT_CAPACITY = 10
  

  # def initialize(options = {})
  #   self.capacity = options.fetch(:capacity, capacity)
  #   self.bikes
  # end

  # when created container should have an empty array of bikes
  def bikes
    @bikes ||= []
  end

  # it should have a capacity
  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end

#it should know when it's full
  def full?
    bike_count >= capacity
  end
  
  # the container should be able to count the bikes
  def bike_count
    bikes.count
  end

  #it should be able to accept a bike
  def load(bike)
  self.full? ? "Full!" : @bikes << bike
  end

  #it should provide a list of functioning bikes
  def functioning_bikes
    bikes.reject {|bike| bike.broken?}
  end

  #it should provide a list of broken bikes
  def broken_bikes
    bikes.select {|bike| bike.broken?}
  end

  #REPETITION!!?!?

  #it should be able to release a functional bike
  def offload_functioning_bike
    released_bike = functioning_bikes.pop
    bikes.delete(released_bike)
    released_bike
  end 

  #.. or a broken bike
  def offload_broken_bike
    released_bike = broken_bikes.pop
    bikes.delete(released_bike)
    released_bike
  end

  #it knows if it is possible to get another broken bike
  def should_collect_broken_bikes?(container)
    !self.full? && container.broken_bikes.count >= 1 
  end

  #.. and can demand as many as possible
  def demand_broken_bikes_from(container)
    while should_collect_broken_bikes?(container) do
      collected_bike = container.offload_broken_bike
      load(collected_bike)
    end
  end
  
  #it knows if it is possible to get another working bike
  def should_collect_functioning_bikes?(container)
    !self.full? && container.functioning_bikes.count >= 1
  end

  #.. and can demand as many as possible
  def demand_functioning_bikes_from(container)
    while should_collect_functioning_bikes?(container) do
      collected_bike = container.offload_functioning_bike
      load(collected_bike)
    end
  end
end
