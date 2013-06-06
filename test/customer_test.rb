require 'test/unit'

require File.expand_path('../../customer.rb', __FILE__)
require File.expand_path('../../movie.rb', __FILE__)
require File.expand_path('../../rental.rb', __FILE__)

class CustomerTest < Test::Unit::TestCase
  def setup
    @customer = Customer.new("Tobi")
  end

  def test_regular_movie_rented_two_days
    @customer.add_rental(Rental.new(Movie.new("Casablanca", Movie::REGULAR), 2))
    assert_match "\tCasablanca\t2", @customer.statement
  end
  
  def test_regular_movie_rented_three_days
    @customer.add_rental(Rental.new(Movie.new("Casablanca", Movie::REGULAR), 3))
    assert_match "\tCasablanca\t3.5", @customer.statement
  end

  def test_new_release_movie_rented_one_day
    @customer.add_rental(Rental.new(Movie.new("The Impossible", Movie::NEW_RELEASE), 1))
    assert_match "\tThe Impossible\t3", @customer.statement
  end
  
  def test_childrens_movie_rented_three_days
    @customer.add_rental(Rental.new(Movie.new("Barbie", Movie::CHILDRENS), 3))
    assert_match "\tBarbie\t1.5", @customer.statement
  end
  
  def test_childrens_movie_rented_four_days
    @customer.add_rental(Rental.new(Movie.new("Barbie", Movie::CHILDRENS), 4))
    assert_match "\tBarbie\t3", @customer.statement
  end

  def test_frequent_renter_points_rented_one_day
    @customer.add_rental(Rental.new(Movie.new("The Impossible", Movie::NEW_RELEASE), 1))
    assert_match "You earned 1 frequent renter points", @customer.statement
  end

  def test_frequent_renter_points_rented_two_days
    @customer.add_rental(Rental.new(Movie.new("The Impossible", Movie::REGULAR), 2))
    assert_match "You earned 1 frequent renter points", @customer.statement
  end
  
  def test_frequent_renter_points_new_release_rented_two_days
    @customer.add_rental(Rental.new(Movie.new("The Impossible", Movie::NEW_RELEASE), 2))
    assert_match "You earned 2 frequent renter points", @customer.statement
  end
end
