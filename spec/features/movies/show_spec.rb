require 'rails_helper'

RSpec.describe 'Movie Details Page', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam@email.com')
    @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @party = ViewingParty.create!(date: "2023-12-01", start_time: "07:25", duration: 175, movie_id: 278)
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end

  it "has buttons to create Viewing Party and return to Discover Page", :vcr do
    visit user_discover_index_path(@user_1)

    fill_in("Movie Title", with: "2001")
    click_button("Search by Movie Title")
    click_link("2001: A Space Odyssey")

    expect(page).to have_button("Create a Viewing Party")
    expect(page).to have_button("Return to Discover Page")
  end

  it "has all required info", :vcr do
    visit user_discover_index_path(@user_1)

    fill_in("Movie Title", with: "2001")
    click_button("Search by Movie Title")
    click_link("2001: A Space Odyssey")

    expect(page).to have_content("2001: A Space Odyssey")
    expect(page).to have_content("Vote Average: 8.076")
    expect(page).to have_content("Runtime: 2 hours, 29 minutes")
    expect(page).to have_content("Genre(s): Science Fiction, Mystery, and Adventure")
    expect(page).to have_content("Summary: Humanity finds a mysterious object buried beneath the lunar surface and sets off to find its origins with the help of HAL 9000, the world's most advanced super computer.")
    expect(page).to have_content("Cast: Keir Dullea, Gary Lockwood, William Sylvester, Douglas Rain, Daniel Richter, Leonard Rossiter, Margaret Tyzack, Robert Beatty, Sean Sullivan, and Frank Miller")
    expect(page).to have_content("Total Reviews: 11")
    expect(page).to have_content("Review: There are many great predictions hinting to future (it is from 1968 - can you believe it?) innovations throughout the movie. I might not have found all them because I keep falling asleep while watching it but I will keep trying to find them all.")
  end

  it "has a button for similar movies", :vcr do
    visit user_discover_index_path(@user_1)

    fill_in("Movie Title", with: "2001")
    click_button("Search by Movie Title")
    click_link("2001: A Space Odyssey")
    click_button("Get Similar Movies")

    expect(current_path).to eq(user_movie_similar_index_path(@user_1, 62))
  end
end