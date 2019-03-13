require "./lib/renter"
require "minitest/autorun"
require "./lib/dock"
require "./lib/boat"

class DockTest < Minitest::Test

def setup
  @dock =Dock.new("The Rowing Dock", 3)
  @kayak_1 = Boat.new(:kayak, 20)
  @kayak_2 = Boat.new(:kayak, 20)
  @sup_1 = Boat.new(:standup_paddle_board, 15)
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

end
