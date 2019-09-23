require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is valid with all fields set' do
      @category = Category.new(name: 'chocolate')
      @product = Product.new(name: 'Laz-e-body', price: 1500, quantity: 5, category:@category)

      expect(@product).to be_valid
    end

    it 'is not valid without a name' do
      @category = Category.new(name: 'peanuts')
      @product = Product.new(name: nil, category: @category)

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to_not be_empty
    end

    it 'is not valid without a price' do
      @category = Category.new(name: 'squirrels')
      @product = Product.new(price: nil, category: @category)

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to_not be_empty
    end


    it 'is not valid without a quantity' do
      @category = Category.new(name: 'candy')
      @product = Product.new(quantity:nil, category: @category)

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to_not be_empty
    end

    it 'is not valid without a category' do
      @product = Product.new(name: 'Laz-e-body', price: 1500, quantity: 5)

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to_not be_empty
    end
  end
end
