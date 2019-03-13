class Dock
  attr_reader :name, :max_rental_time, :rental_log
  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log ={}
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    card = @rental_log[boat].credit_card_number
    if boat.hours_rented <= @max_rental_time
      boat_cost = boat.price_per_hour * boat.hours_rented
    else
      boat_cost = boat.price_per_hour * @max_rental_time
    end
    {card_number: card, amount: boat_cost}
  end

end
