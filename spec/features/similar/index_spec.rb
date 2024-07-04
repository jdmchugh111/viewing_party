require 'rails_helper'

RSpec.describe 'Similar Movies Page', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam@email.com')
    @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @party = ViewingParty.create!(date: "2023-12-01", start_time: "07:25", duration: 175, movie_id: 278)
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end

  it "has all similar movie info", :vcr do
    visit user_discover_index_path(@user_1)

    fill_in("Movie Title", with: "2001")
    click_button("Search by Movie Title")
    click_link("2001: A Space Odyssey")
    click_button("Get Similar Movies")

    expect(page).to have_content("Similar Movies: 2001: A Space Odyssey")
    expect(page).to have_content("Title: Metropolis")
    expect(page).to have_content("Summary: In a futuristic city sharply divided between the rich and the poor, the son of the city's mastermind meets a prophet who predicts the coming of a savior to mediate their differences.")
    expect(page).to have_content("Release Date: 1927-02-06")
    expect(page).to have_content("Vote Average: 8.14")
    expect(page).to have_css(('.poster-image'))
  end
end