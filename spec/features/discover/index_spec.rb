require 'rails_helper'

RSpec.describe 'Discover page', type: :feature do

  it "exists" do
    1.times do 
      User.create!(name: Faker::Name.name, email: Faker::Internet.email)
    end
    visit user_discover_index_path(User.first)

    click_button("Discover Top Rated Movies")

    expect(current_path).to eq(user_movies_path(User.first))
  end
end