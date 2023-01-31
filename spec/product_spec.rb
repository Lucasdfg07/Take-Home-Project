require 'tax_calculator'
require 'byebug'

RSpec.describe Product do
  let(:data) { "2 book at 12.49" }

  describe '#initialize' do
    context 'when we instance a new product' do
      let(:product) { described_class.new(data) }

      it 'returns proper values' do
        expect(product.price).not_to be_nil
        expect(product.amount).not_to be_nil
        expect(product.description).not_to be_nil
      end
    end
  end

  describe '#imported?' do
    context 'when we set an imported product' do
      let(:data) { "1 imported box of chocolates: 10.50" }
      let(:product) { described_class.new(data) }

      it 'returns true' do
        expect(product.imported?).to be(true)
      end
    end

    context 'when we do not set an imported product' do
      let(:product) { described_class.new(data) }

      it 'returns false' do
        expect(product.imported?).to be(false)
      end
    end
  end
end