require_relative 'product'
require_relative 'concerns/float'

class TaxCalculator
  PRODUCTS_WITHOUT_TAXES = ["book", "chocolate", "pill"]

  def calculate_final_price(products)
    initialize_global_taxes_and_total
    calculate_tax_for_each_product_of(products)

    @sales_tax = @sales_tax.round_to_half if @sales_tax > 0
    print_taxes_and_final_price
  end

  private

  def initialize_variables(product_and_price)
    @product = Product.new(product_and_price)
    @importation_tax = 0
    @normal_tax = 0
  end

  def initialize_global_taxes_and_total
    @sales_tax = 0
    @total = 0
    @products_info = []
  end

  def calculate_tax_for_each_product_of(products)
    products.each do |product_and_price|
      initialize_variables(product_and_price)

      if product_name_in_whitelist && !@product.imported?
        set_product_data
        sum_taxes_and_total
        next
      end

      tax_product
      sum_taxes_and_total
      set_product_data
    end
  end

  def sum_taxes_and_total
    @sales_tax += @importation_tax + @normal_tax
    @total += final_price.round_to_half
  end

  def tax_product
    @importation_tax = tax_product_with_aliquot(5) if @product.imported?
    @normal_tax = tax_product_with_aliquot(10) unless product_name_in_whitelist
  end

  def tax_product_with_aliquot(tax)
    (@product.price * tax/100)
  end

  def product_name_in_whitelist
    PRODUCTS_WITHOUT_TAXES.map do |product|
      return true if @product.description.include? product
    end

    false
  end

  def final_price
    @product.amount * (@product.price + @importation_tax + @normal_tax)
  end

  def set_product_data
    @products_info << "#{@product.amount} #{@product.description}: #{final_price.round_to_half.with_two_decimals}"
  end

  def print_taxes_and_final_price
    "#{ @products_info.join("\n")} \nSales Taxes: #{@sales_tax.with_two_decimals} \nTotal: #{@total}"
  end
end