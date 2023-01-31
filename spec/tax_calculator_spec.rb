require 'tax_calculator'
require 'byebug'

RSpec.describe TaxCalculator do
  let(:tax_calculator) { described_class.new }

  describe '#calculate_final_price' do
    context 'when we test first round products' do
      let(:products) {
        [
          '2 book at 12.49',
          '1 music CD at 14.99',
          '1 chocolate bar at 0.85'
        ]
      }

      it 'returns proper values' do
        response = tax_calculator.calculate_final_price(products)
        expect(response).to include("2 book: 24.98")
        expect(response).to include("1 music CD: 16.49")
        expect(response).to include("1 chocolate bar: 0.85")
        expect(response).to include("Sales Taxes: 1.50")
        expect(response).to include("Total: 42.32")
      end
    end

    context 'when we test second round products' do
      let(:products) {
        [
          '1 imported box of chocolates at 10.00',
          '1 imported bottle of perfume at 47.50'
        ]
      }

      it 'returns proper values' do
        response = tax_calculator.calculate_final_price(products)
        expect(response).to include("1 imported box of chocolates: 10.50")
        expect(response).to include("1 imported bottle of perfume: 54.65")
        expect(response).to include("Sales Taxes: 7.65")
        expect(response).to include("Total: 65.15")
      end
    end

    context 'when we test third round products' do
      let(:products) {
        [
          '1 imported bottle of perfume at 27.99',
          '1 bottle of perfume at 18.99',
          '1 packet of headache pills at 9.75',
          '3 imported boxes of chocolates at 11.25'
        ]
      }

      it 'returns proper values' do
        response = tax_calculator.calculate_final_price(products)
        expect(response).to include("1 imported bottle of perfume: 32.19")
        expect(response).to include("1 bottle of perfume: 20.89")
        expect(response).to include("1 packet of headache pills: 9.75")
        expect(response).to include("3 imported boxes of chocolates: 35.45")
        expect(response).to include("Sales Taxes: 6.66")
        expect(response).to include("Total: 98.28")
      end
    end
  end
end