def sign_in
    visit '/users/sign_up'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'testtest'
    fill_in 'Password confirmation', with: 'testtest'
    click_button 'Sign up'
end

def add_restaurant_and_return
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in :name, with: 'My restaurant'
  fill_in :description, with: 'A great place to eat'
  click_button 'Add Restaurant'
end

def visit_my_restaurant
  add_restaurant_and_return
  click_link 'My restaurant'
end