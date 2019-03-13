require "./lib/boat"
require "minitest/autorun"


class BoatTest < Minitest::Test

  def test_has_type
    kayak = Boat.new(:kayak, 20)
    assert_equal :kayak, kayak.type
  end

  def test_has_price_per_hour
    kayak = Boat.new(:kayak, 20)
    assert_equal 20, kayak.price_per_hour
  end

  def test_tracks_hours_rented
    kayak = Boat.new(:kayak, 20)
    assert_equal 0, kayak.hours_rented
    kayak.add_hour
    kayak.add_hour
    assert_equal 2, kayak.hours_rented
  end

end
