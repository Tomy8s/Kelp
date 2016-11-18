require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'shuold display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'NOOO RESTAURANTS EVER!!!'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Dandos')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Dandos'
      expect(page).not_to have_content 'NOOO RESTAURANTS EVER!!!'
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_in
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'users must be signed in to create a restaurant' do
      visit '/'
      click_link 'Add a restaurant'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    context 'an invalid restaurant' do
      scenario 'does no let you submit a name that is too short' do
        sign_in
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'aa'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'aa'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'lets a user view a restaurant' do
     visit '/'
     click_link 'KFC'
     expect(page).to have_content 'KFC'
     expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'Nandos', description: 'grilled chicken' }

    scenario 'let user edit a restaurant' do
      sign_in
      click_link 'Nandos'
      click_link 'Edit Nandos'
      fill_in 'Name', with: 'Nandooos'
      fill_in 'Description', with: 'grilled cat'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Nandooos'
      expect(page).to have_content 'grilled cat'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'users must be signed in to edit a restaurant' do
      visit '/'
      click_link 'Nandos'
      click_link 'Edit Nandos'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

  context 'deleting restaurants' do
    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }
    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_in
      click_link 'KFC'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'users must be signed in to delete a restaurant' do
      visit '/'
      click_link 'KFC'
      click_link 'Delete KFC'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

end
