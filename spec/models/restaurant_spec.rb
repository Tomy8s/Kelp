require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it 'is not valid with a name less than 3 chars' do
    User.create(email: 'abc@123.com', password: '123456')
    restaurant = Restaurant.new(name: 'a', user: User.first)
    expect(restaurant).to have(1).error_on :name
    expect(restaurant).not_to be_valid
  end

  it 'is not valid with an existing name' do
    User.create(email: 'abc@123.com', password: '123456')
    Restaurant.create(name: 'a restaurant', user: User.first)
    restaurant = Restaurant.new(name: 'a restaurant', user: User.first)
    expect(restaurant).to have(1).error_on :name
    expect(restaurant).not_to be_valid
  end

  describe 'reviews' do
    describe 'build_with_user' do

      let(:user) { User.create email: 'test@test.com', password: '123456'}
      let(:restaurant) {Restaurant.create name: 'KFC'}
      let(:review_params) { { rating: 5, comments: 'crap'} }

      subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a review associated to the user' do
        expect(review.user).to eq user
      end
    end
  end


end
