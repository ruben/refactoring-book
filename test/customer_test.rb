require 'test/unit'

require File.expand_path('../../customer.rb', __FILE__)
require File.expand_path('../../movie.rb', __FILE__)
require File.expand_path('../../rental.rb', __FILE__)

class CustomerTest < Test::Unit::TestCase
  def setup
    @customer = Customer.new("Tobi")
    @casablanca = Movie.new("Casablanca", Movie::REGULAR)
    @the_impossible = Movie.new("The Impossible", Movie::NEW_RELEASE)
    @barbie =  Movie.new("Barbie", Movie::CHILDRENS)
  end

  def test_regular_movie_rented_two_days
    @customer.add_rental(Rental.new(@casablanca, 2))
    assert_match "\tCasablanca\t2", @customer.statement
  end
  
  def test_regular_movie_rented_three_days
    @customer.add_rental(Rental.new(@casablanca, 3))
    assert_match "\tCasablanca\t3.5", @customer.statement
  end

  def test_new_release_movie_rented_one_day
    @customer.add_rental(Rental.new(@the_impossible, 1))
    assert_match "\tThe Impossible\t3", @customer.statement
  end
  
  def test_childrens_movie_rented_three_days
    @customer.add_rental(Rental.new(@barbie, 3))
    assert_match "\tBarbie\t1.5", @customer.statement
  end
  
  def test_childrens_movie_rented_four_days
    @customer.add_rental(Rental.new(@barbie, 4))
    assert_match "\tBarbie\t3", @customer.statement
  end

  def test_frequent_renter_points_rented_one_day
    @customer.add_rental(Rental.new(@the_impossible, 1))
    assert_match "You earned 1 frequent renter points", @customer.statement
  end

  def test_frequent_renter_points_rented_two_days
    @customer.add_rental(Rental.new(@casablanca, 2))
    assert_match "You earned 1 frequent renter points", @customer.statement
  end
  
  def test_frequent_renter_points_new_release_rented_two_days
    @customer.add_rental(Rental.new(@the_impossible, 2))
    assert_match "You earned 2 frequent renter points", @customer.statement
  end

  def test_total_amount
    @customer.add_rental(Rental.new(@casablanca, 1))
    @customer.add_rental(Rental.new(@the_impossible, 1))
    assert_match "Amount owed is 5", @customer.statement
  end
end
