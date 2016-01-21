module SigningUpAndIn

  def sign_up(email: 'test@example.com',
              password: 'testtest',
              password_confirmation: 'testtest')
    visit '/'
    click_link('Sign up')
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    fill_in('Password confirmation', with: password_confirmation)
    click_button('Sign up')
  end

  def create_restaurant(name: 'KFC')
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
    click_button 'Create Restaurant'
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

end
