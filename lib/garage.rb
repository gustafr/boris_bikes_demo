require_relative './bike_container'

class Garage

  include BikeContainer

  # def initialize(options = {})
  #   self.capacity = options.fetch(:capacity, capacity)
  #   self.bikes
  # end

  def repair!
    bikes.each {|bike| bike.fix!}
  end

  
end