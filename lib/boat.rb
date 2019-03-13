class Boat
attr_reader :type, :price_per_hour, :hours_rented, :returned
def initialize(type, price_per_hour)
  @type = type
  @price_per_hour = price_per_hour
  @hours_rented = 0
  @returned = true
end

def add_hour
  @hours_rented +=1
end

def go_out
  @returned = false
end

def come_back
  @returned = true
end

end
