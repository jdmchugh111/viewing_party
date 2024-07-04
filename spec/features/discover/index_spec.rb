require 'rails_helper'

RSpec.describe 'Discover page', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam@email.com')
    @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @party = ViewingParty.create!(date: "2023-12-01", start_time: "07:25", duration: 175, movie_id: 278)
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end

  it "has a button to Discover Top Rated Movies", :vcr do
    visit user_discover_index_path(@user_1)

    expect(page).to have_button("Discover Top Rated Movies")
    
    click_button("Discover Top Rated Movies")
    expect(current_path).to eq(user_movies_path(@user_1))
  end

  it "has a search field to search by movie title", :vcr do
    visit user_discover_index_path(@user_1)

    fill_in("Movie Title", with: "2001")
    click_button("Search by Movie Title")

    expect(current_path).to eq(user_movies_path(@user_1))
  end

  describe "sad path" do
    it "returns an error if you don't fill in search field", :vcr do
      visit user_discover_index_path(@user_1)

      fill_in("Movie Title", with: "")
      click_button("Search by Movie Title")

      expect(current_path).to eq(user_discover_index_path(@user_1))
      expect(page).to have_content("Search field cannot be empty")
    end
  end

end