require 'rails_helper'

feature 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count', js: true do
    visit('/restaurants')
    click_link 'Endorse'
    expect(page).to have_content('1 endorsement')
  end

  scenario 'the endorsement count correltes to the number of times the link is clicked', js: true do
    visit('/restaurants')
    click_link 'Endorse'
    click_link 'Endorse'
    click_link 'Endorse'
    expect(page).to have_content('3 endorsements')
  end
end
