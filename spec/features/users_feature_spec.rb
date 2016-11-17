require 'rails_helper'

feature 'User can sign in and out' do
  context 'homepage for user not signed-in' do
    it 'should see "sign in" and "sign up" links' do
      visit '/'
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Sign up'
    end
    it 'should not see "sign out" link' do
      visit '/'
      expect(page).not_to have_link 'Sign out'
    end
  end

  context 'User is signed in' do
    before do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'testtest'
      fill_in 'Password confirmation', with: 'testtest'
      click_button 'Sign up'
    end

    it 'should see "sign out" link' do
      visit '/'
      expect(page).to have_link 'Sign out'
    end

    it 'should not see a "sign in" or "sign up" link' do
      visit '/'
      expect(page).not_to have_link 'Sign in'
      expect(page).not_to have_link 'Sign up'
    end
  end

  context 'User is not signed in' do
    before { Restaurant.create( name: 'KFC') }

    scenario 'user tries to create a restaurant not logged in' do
      visit '/'
      click_link 'Add a restaurant'
      expect(page).to have_content 'Log in'
      expect(current_path).to be '/users/sign_in'
    end

    scenario 'user tries to delete restaurant' do
      visit '/'
      expect(page).not_to have_link 'Delete KFC'
    end

  end
end
