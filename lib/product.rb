class Product
  attr_accessor :price, :amount, :description

  def initialize(product_and_price)
    @description, @price = product_and_price[2..].split(' at ')
    @price = @price.to_f

    @amount = product_and_price[0].to_i
  end

  def imported?
    self.description.include?("imported")
  end
end