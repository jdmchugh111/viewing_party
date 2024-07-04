require 'rails_helper'

RSpec.describe 'Viewing Party Show Page', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam@email.com')
    @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @party = ViewingParty.create!(date: "2023-12-01", start_time: "07:25", duration: 175, movie_id: 278)
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end

  it "should have logo images", :vcr do
    visit user_discover_index_path(@user_1)

    fill_in("Movie Title", with: "2001")
    click_button("Search by Movie Title")
    click_link("2001: A Space Odyssey")
    click_button("Create a Viewing Party")

    fill_in("Duration", with: 149)
    fill_in("When", with: "07/19/2024")
    fill_in("Start time", with: "11:11 PM")
    fill_in("Guest email 1", with: "tommy@email.com")
    click_button("Create Viewing Party")

    visit user_movie_viewing_party_path(@user_1, 62, 1)

    expect(page).to have_css(('.provider-logo'), count: 14)
  end

  it "should have data attribution", :vcr do
    visit user_discover_index_path(@user_1)

    fill_in("Movie Title", with: "2001")
    click_button("Search by Movie Title")
    click_link("2001: A Space Odyssey")
    click_button("Create a Viewing Party")

    fill_in("Duration", with: 149)
    fill_in("When", with: "07/19/2024")
    fill_in("Start time", with: "11:11 PM")
    fill_in("Guest email 1", with: "tommy@email.com")
    click_button("Create Viewing Party")

    visit user_movie_viewing_party_path(@user_1, 62, 1)

    expect(page).to have_content("Buy/Rent data provided by JustWatch")
  end

end