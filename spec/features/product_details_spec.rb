require 'rails_helper'

require 'rails_helper'

RSpec.feature "Visitor navigates to the product page by clicking on a product", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    visit root_path

    page.find(:link, 'Details »', match: :first).click

    
    #save_screenshot('test2_0.png') 

    #sleep 1
    #save_screenshot('test2_2.png') 

    expect(page).to have_css 'section.products-show', count: 1
    save_screenshot('test2_3.png') 
  end

end 

