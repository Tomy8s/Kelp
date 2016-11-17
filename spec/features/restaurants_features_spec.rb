require 'rails_helper'

feature 'restaurants' do

	context 'no restaurants have been added ' do
		scenario 'should display a ' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurants yet'
			expect(page).to have_link 'Add a restaurant'
		end
	end

	context 'restaurants have been added' do
		before do
			sign_in
			add_restaurant_and_return
		end

		scenario 'display restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'My restaurant'
			expect(page).not_to have_content 'No restaurants yet'
		end
	end

	context 'adding a restaurant' do
		scenario 'user adds a new restaurant and the restaurant is displayed on the page' do
			sign_in
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in :name, with: "McDonald's"
			click_button 'Add Restaurant'
			expect(page).to have_content "McDonald's"
			expect(current_path).to eq '/restaurants'
		end
	end

	context 'displaying an individual restaurant' do
		before do
			sign_in
			add_restaurant_and_return
		end
		scenario 'lets the user view a restaurant' do
			visit '/restaurants'
			click_link 'My restaurant'
			expect(page).to have_content 'My restaurant'
			expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
		end
	end

	context 'user add description to restaurant' do
		scenario 'user adds a new restaurant and description' do
			sign_in
			add_restaurant_and_return
			click_link 'My restaurant'
			expect(page).to have_content 'A great place to eat'
		end
	end

	context 'editing a restaurant' do
		before do
			sign_in
			add_restaurant_and_return
		end
		scenario 'lets user edit restuarant' do
			visit '/restaurants'
			click_link 'My restaurant'
			click_link 'Edit'
			fill_in :name, with: 'trat'
			click_button 'Update Restaurant'
			expect(page).to have_content 'trat'
			expect(page).not_to have_content 'My restaurant'
		end
	end

	context 'deleting a restaurant' do
		scenario 'user deletes a restaurant' do
			sign_in
			visit_my_restaurant
			click_link 'Delete'
			expect(page).to have_content 'My restaurant has been deleted'
		end
	end

	context 'not allowing the same name' do
    scenario 'user adds a restaurant with an existing name' do
			sign_in
      add_restaurant_and_return
      add_restaurant_and_return
      expect(page).to have_content 'Name has already been taken'
    end
	end
end
