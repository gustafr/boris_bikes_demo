require_relative('./bike_container')

class Van
  
  

  # def initialize
  #   @capacity = 10
  #   @bikes = []
  # end
  include BikeContainer

  attr_accessor :bike

  def initialize(options = {})
    @capacity = options.fetch(:capacity, capacity)
    @bikes = []
  end
end