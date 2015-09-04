class Person

  attr_reader :bike

  def has_a_bike?
    @bike != nil
  end

  def rents_a_bike_from(station)
    return 'Not possible to rent more than 1 bike' if has_a_bike?
    @bike = station.offload_functioning_bike
  end

  def returns_their_bike_to(station)
    station.load(@bike)
    @bike=nil 
  end

  def crashes!
    @bike.break!
  end

end
