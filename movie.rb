class Movie
	REGULAR = 0
	NEW_RELEASE = 1
	CHILDRENS = 2

	attr_reader :title
	attr_accessor :price_code

  def price_code=(value)
    @price_code = value
    @price = case price_code
             when REGULAR then RegularPrice.new
             when NEW_RELEASE then NewReleasePrice.new
             when CHILDRENS then ChildrensPrice.new
             end
  end

	def initialize(title, price_code)
		@title, self.price_code = title, price_code
	end

  def charge(days_rented)
    return @price.charge(days_rented)
  end

  def frequent_renter_points(days_rented)
    @price.frequent_renter_points(days_rented)
  end
end
