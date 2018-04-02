require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it "saves a product" do
      @category = Category.create(name: 'Home')
      @product = Product.create(name: 'Product', price: 100, quantity: 1, category: @category)
      expect(Product.find(@product.id)).not_to be_nil
    end

    it "without a name it is impossible to save" do
      @category = Category.create(name: 'Home')
      @product = Product.create(name: nil, price: 100, quantity: 1, category: @category)
      expect(@product.errors.full_messages_for(:name)).to eq ["Name can't be blank"]
    end

    it "without a price it is impossible to save" do
      @category = Category.create(name: 'Home')
      @product = Product.create(name: 'Product', price: nil, quantity: 1, category: @category)
      expect(@product.errors.full_messages_for(:price)).to eq ["Price is not a number", "Price can't be blank"]
    end

    it "without a quantity it is impossible to save" do
      @category = Category.create(name: 'Home')
      @product = Product.create(name: 'Product', price: 100, quantity: nil, category: @category)
      expect(@product.errors.full_messages_for(:quantity)).to eq ["Quantity can't be blank"]
    end

    it "without a name it is impossible to save" do
      @category = Category.create(name: 'Home')
      @product = Product.create(name: 'Product', price: 100, quantity: 1, category: nil)
      expect(@product.errors.full_messages_for(:category)).to eq ["Category can't be blank"]
    end

  end

end