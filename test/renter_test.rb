require "./lib/renter"
require "minitest/autorun"


class RenterTest < Minitest::Test

def test_has_name
renter = Renter.new("Patrick Star", "4242424242424242")
assert_equal "Patrick Star", renter.name
end

def test_has_credit_card_number
renter = Renter.new("Patrick Star", "4242424242424242")
assert_equal "4242424242424242", renter.credit_card_number 
end


end
