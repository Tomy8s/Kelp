require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'Nandos', description: 'grilled chicken' }

  scenario 'allows users to leave a review using a form' do
    sign_in
    click_link 'Nandos'
    click_link 'Review Nandos'
    fill_in "Thoughts", with: 'so good'
    select '5', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content 'so good'
  end

  scenario  'users must be signed in to leave a review' do
    visit '/'
    click_link 'Nandos'
    click_link 'Review Nandos'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'user can\'t leave more than one review for the same restaurant' do
    add_restaurant
    2.times{ leave_review }
    expect(page).to have_content 'Error: You have already reviewed A Restaurant'
  end
end
