require 'rails_helper'

feature 'reviews' do
  before do
    sign_up
    create_restaurant
  end

  context 'leaving a review' do
    scenario 'allows users to leave a review using a form' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('so so')
    end

    scenario 'only allows one review per restaurant per user' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(page).to have_content("Sorry, you have already left a review for that restaurant.")
    end
  end

  context 'deleting a review' do
    scenario 'delete reviews when restaurant is deleted' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Delete KFC'
      expect(Review.first).not_to have_content('so so')
    end

    scenario 'user can delete their own reviews' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link('Delete review')
      expect(page).not_to have_content('so so')
      expect(page).to have_content('Review deleted successfully')
      expect(Review.first).to eq(nil)
    end

    scenario 'user can not delete a different users reviews' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link('Sign out')
      sign_up(email: 'different@user.com')
      click_link('Delete review')
      expect(page).not_to have_content('Review deleted successfully')
      expect(page).to have_content('Sorry, you can not delete other users reviews')
    end
  end

end
