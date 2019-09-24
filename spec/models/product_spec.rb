require 'rails_helper'

RSpec.describe Product, type: :model do
  cat1 = Category.find_or_create_by! name: 'Apparel'
  product = cat1.products.new(name: 'Laz-e-body', price_cents: 1500, quantity: 5)
  describe 'Validations' do
    it 'is valid with all fields set' do
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product.name = nil
      expect(product).to_not be_valid
      expect(product.errors[:name]).to_not be_empty
    end

    it 'is not valid without a price' do
      product.price_cents = nil

      expect(product).to_not be_valid
      expect(product.errors[:price_cents]).to_not be_empty
    end

    it 'is not valid without a quantity' do
      product.quantity = nil

      expect(product).to_not be_valid
      expect(product.errors[:quantity]).to_not be_empty
    end

    it 'is not valid without a category' do
      product2 = Product.new(name: 'Laz-e-body', price_cents: 1500, quantity: 5)
      expect(product2).to_not be_valid
      expect(product2.errors[:category]).to_not be_empty
    end
  end
end
