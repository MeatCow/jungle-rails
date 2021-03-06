# frozen_string_literal: true

require 'rails_helper'

describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create name: 'Plant'
    end

    it 'should save if all required fields are present' do
      plant = @category.products.new({ name: 'grass', price: 5.00, quantity: 5 })
      plant.validate
      expect(plant.errors.full_messages).to be_empty
    end

    it 'should cause an error if name is not present' do
      plant = @category.products.new({ price: 5.00, quantity: 5 })
      plant.validate
      expect(plant.errors.full_messages).to include "Name can't be blank"
    end

    it 'should cause an error if price is not present' do
      plant = @category.products.new({ name: 'grass', quantity: 5 })
      plant.validate
      expect(plant.errors.full_messages).to include "Price can't be blank"
    end

    it 'should cause an error if quantity is not present' do
      plant = @category.products.new({ name: 'grass', price: 5.00 })
      plant.validate
      expect(plant.errors.full_messages).to include "Quantity can't be blank"
    end

    it 'should cause an error if category is not present' do
      plant = Product.new({ name: 'grass', price: 5.00, quantity: 5 })
      plant.validate
      expect(plant.errors.full_messages).to include "Category can't be blank"
    end
  end
end
