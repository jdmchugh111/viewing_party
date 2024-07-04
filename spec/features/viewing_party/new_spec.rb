require 'rails_helper'

RSpec.describe 'New Viewing Party Page', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam@email.com')
    @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @party = ViewingParty.create!(date: "2023-12-01", start_time: "07:25", duration: 175, movie_id: 278)
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end

  it "should have movie title rendered at the top", :vcr do
    visit user_discover_index_path(@user_1)

    fill_in("Movie Title", with: "2001")
    click_button("Search by Movie Title")
    click_link("2001: A Space Odyssey")
    click_button("Create a Viewing Party")

    expect(current_path).to eq(new_user_movie_viewing_party_path(@user_1, 62))
    expect(page).to have_content("2001: A Space Odyssey")
  end

  it "has all required fields", :vcr do
    visit user_discover_index_path(@user_1)

    fill_in("Movie Title", with: "2001")
    click_button("Search by Movie Title")
    click_link("2001: A Space Odyssey")
    click_button("Create a Viewing Party")

    page.has_field?("Duration", with: 149)
    page.has_field?("When")
    page.has_field?("Start time")
    page.has_field?("Guest email 1")
    page.has_field?("Guest email 2")
    page.has_field?("Guest email 3")
    page.has_button?("Create Viewing Party")
  end

  it "should redirect user to dashboard, and user is host", :vcr do
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

    expect(current_path).to eq(user_path(@user_1))
    expect(page).to have_content("Host: Sam")
  end

  it "should appear on all invited guests' dashboards", :vcr do
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

    visit user_path(@user_2)
    expect(page).to have_content("Host: Sam")
    expect(page).to have_content("Movie: 2001: A Space Odyssey")
  end

  describe "sad path" do
    it "returns an error if duration, date, or time are left blank", :vcr do
      visit user_discover_index_path(@user_1)

      fill_in("Movie Title", with: "2001")
      click_button("Search by Movie Title")
      click_link("2001: A Space Odyssey")
      click_button("Create a Viewing Party")

      click_button("Create Viewing Party")

      expect(current_path).to eq(new_user_movie_viewing_party_path(@user_1, 62))
      expect(page).to have_content("Duration, Date, and Time must be entered")
    end
  end
end