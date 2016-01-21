require 'rails_helper'

feature 'rails-helper' do
  before do
    sign_up
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
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

    # scenario 'only allows one review per restaurant per user' do
    #   visit '/restaurants'
    #   click_link 'Review KFC'
    #   fill_in "Thoughts", with: "so so"
    #   select '3', from: 'Rating'
    #   click_button 'Leave Review'
    #   visit '/restaurants'
    #   click_link 'Review KFC'
    #   fill_in "Thoughts", with: "dead good"
    #   select '5', from: 'Rating'
    #   click_button 'Leave Review'
    #
    # end
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
  end

end
