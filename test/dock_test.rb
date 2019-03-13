require "./lib/renter"
require "minitest/autorun"
require "./lib/dock"
require "./lib/boat"
require "pry"

class DockTest < Minitest::Test

def setup
  @dock =Dock.new("The Rowing Dock", 3)
  @kayak_1 = Boat.new(:kayak, 20)
  @kayak_2 = Boat.new(:kayak, 20)
  @sup_1 = Boat.new(:standup_paddle_board, 15)
  @sup_2 = Boat.new(:standup_paddle_board, 15)
  @canoe = Boat.new(:canoe, 25)
  @patrick = Renter.new("Patrick Star", "4242424242424242")
  @eugene = Renter.new("Eugene Crabs", "1313131313131313")
end

def test_has_name
  assert_equal "The Rowing Dock", @dock.name
end

def test_has_max_rental_time
  assert_equal 3, @dock.max_rental_time
end

def test_rental_log
  @dock.rent(@kayak_1, @patrick)
  assert_equal ({@kayak_1 => @patrick}), @dock.rental_log
  @dock.rent(@sup_1, @eugene)
  assert_equal ({@kayak_1 => @patrick, @sup_1 => @eugene}), @dock.rental_log
end

def test_charge
  @dock.rent(@kayak_1, @patrick)
  @kayak_1.add_hour
  @kayak_1.add_hour
  assert_equal ({
                  :card_number => "4242424242424242",
                  :amount => 40
                }), @dock.charge(@kayak_1)
  @dock.rent(@sup_1, @eugene)
  5.times{@sup_1.add_hour}
  assert_equal ({
                  :card_number => "1313131313131313",
                  :amount => 45
                }), @dock.charge(@sup_1)
end



def test_log_hour
@dock.rent(@kayak_1, @patrick)
@dock.rent(@kayak_2, @patrick)
@dock.log_hour
assert_equal 1, @kayak_1.hours_rented
assert_equal 1, @kayak_2.hours_rented
@dock.rent(@canoe, @eugene)
@dock.log_hour
assert_equal 2, @kayak_2.hours_rented
assert_equal 1, @canoe.hours_rented
end



def test_return
  @dock.rent(@kayak_1, @patrick)
  @dock.log_hour
  @dock.return(@kayak_1)
  @dock.log_hour
  assert_equal 1, @kayak_1.hours_rented
end

def test_revenue
  @dock.rent(@kayak_1, @patrick)

  @dock.rent(@kayak_2, @patrick)
  @dock.rent(@kayak_2, @patrick)
  @dock.log_hour
  @dock.rent(@canoe, @patrick)
  @dock.log_hour
  assert_equal 0, @dock.revenue
  @dock.return(@kayak_2)
  @dock.return(@kayak_1)
  @dock.return(@canoe)
  assert_equal 105, @dock.revenue
  @dock.rent(@sup_1, @eugene)
  @dock.rent(@sup_2, @eugene)
  5.times{@dock.log_hour}
  binding.pry
  @dock.return(@sup_1)
  binding.pry
  @dock.return(@sup_2)
  assert_equal 195, @dock.revenue
end

end
