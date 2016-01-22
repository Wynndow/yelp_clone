require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do

    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      create_restaurant
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'can not be done if not logged in' do
      visit '/'
      click_link('Add a restaurant')
      expect(page).to have_content('Log in')
    end

    scenario 'can upload an image' do
      sign_up
      click_link('Add a restaurant')
      fill_in 'Name', with: 'Hawksmoor'
      page.attach_file 'restaurant[image]', './spec/support/hawksmoor.png'
      click_button "Create Restaurant"
    end

  end

  context 'viewing restaurants' do

    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'KFC' }

    scenario 'let a user edit a restaurant they created' do
      sign_up
      create_restaurant(name: 'McDonalds')
      visit '/restaurants'
      click_link 'Edit McDonalds'
      fill_in 'Name', with: 'MaccyD'
      click_button 'Update Restaurant'
      expect(page).to have_content 'MaccyD'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'let a user edit a restaurant only if they created it' do
      sign_up
      create_restaurant(name: 'Burger King')
      click_link 'Sign out'
      sign_up(email: 'different@user.com')
      visit '/restaurants'
      expect(page).not_to have_link 'Edit Burger King'
    end
  end

  context 'deleting restaurants' do

    before { Restaurant.create name: 'KFC' }

    scenario 'can be deleted by a user who created the restaurant' do
      sign_up
      create_restaurant(name: 'Burger King')
      click_link 'Sign out'
      sign_up(email: 'different@user.com')
      visit '/restaurants'
      expect(page).not_to have_link 'Delete Burger King'
    end

    scenario 'does not remove a restaurant if not the users' do
      sign_up
      visit 'restaurants'
      expect(page).not_to have_link 'Delete KFC'
      expect(page).to have_content 'Review KFC'
    end

    scenario 'restaurants are removed if associated user is deleted' do
      sign_up
      create_restaurant(name: 'Burger King')
      User.first.destroy
      expect(Restaurant.last.name).not_to eq('Burger King')
      expect(Restaurant.last.name).to eq('KFC')
    end
  end

  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      sign_up
      create_restaurant(name: 'kf')
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

end
