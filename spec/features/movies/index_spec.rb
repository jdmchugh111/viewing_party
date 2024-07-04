require 'rails_helper'

RSpec.describe 'Movie Results Page', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam@email.com')
    @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @party = ViewingParty.create!(date: "2023-12-01", start_time: "07:25", duration: 175, movie_id: 278)
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end

  it "has a title linkt to movie show page, vote average, and return to Discover Page button", :vcr do
    visit user_discover_index_path(@user_1)

    click_button("Discover Top Rated Movies")
    expect(current_path).to eq(user_movies_path(@user_1))
    expect(page).to have_link("Shawshank Redemption")
    expect(page).to have_content("Vote Average:")
    expect(page).to have_button("Back To Discover Page")

    click_button("Back To Discover Page")
    expect(current_path).to eq(user_discover_index_path(@user_1))
  end
end