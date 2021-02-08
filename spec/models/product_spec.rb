require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context "Product with all four fields set" do
      @category = Category.create() #could add name:"Clothes" as a param but not necessary
      product = Product.new({name: 'Product1', price_cents: '1000', quantity: '5', category: @category})
      it "should save successfully" do
        expect(product).to be_valid
        expect(product.errors.full_messages).to be_empty
      end
    end
    context "Product with name field left empty" do
      @category = Category.create() #could add name:"Clothes" as a param but not necessary
      product = Product.new({name: nil, price_cents: '1000', quantity: '5', category: @category})
      it "should not save successfully" do
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include "Name can't be blank"
      end
    end
    context "Product with price field left empty" do
      @category = Category.create() #could add name:"Clothes" as a param but not necessary
      product = Product.new({name: 'Product1', price_cents: nil, quantity: '5', category: @category})
      it "should not save successfully" do
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include "Price can't be blank"
      end
    end
    context "Product with quantity field left empty" do
      @category = Category.create() #could add name:"Clothes" as a param but not necessary
      product = Product.new({name: 'Product1', price_cents: '1000', quantity: nil, category: @category})
      it "should not save successfully" do
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include "Quantity can't be blank"
      end
    end
    context "Product with category id field left empty" do
      @category = Category.create() #could add name:"Clothes" as a param but not necessary
      product = Product.new({name: 'Product1', price_cents: '1000', quantity: '5', category: nil})
      it "should not save successfully" do
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include "Category can't be blank"
      end
    end
  end
end
