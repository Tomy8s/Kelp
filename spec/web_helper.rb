def sign_in
  User.create(email:'badger@badger.com', password: "password")
  visit('/')
  click_link "Sign in"
  fill_in "Email", with: "badger@badger.com"
  fill_in "Password", with: "password"
  click_button "Log in"
end

def add_restaurant
  sign_in
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'A Restaurant'
  fill_in 'Description', with: 'A place to eat'
  click_button 'Create Restaurant'
end

def leave_review
  visit '/'
  click_link 'A Restaurant'
  click_link 'Review A Restaurant'
  fill_in 'Thoughts', with: 'Me like'
  select 5, from: 'Rating'
  click_button 'Leave Review'
end