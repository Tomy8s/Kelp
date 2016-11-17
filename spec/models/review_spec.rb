require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'is invalid if the rating is more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
    expect(review).not_to be_valid
  end

  it 'is invalid if user has already reviewed this restaurant' do
    # User.create()
    # Restaurant.create()
    Review.create(restaurant_id: 1, user_id: 1, comments: 'good', rating: 3)
    review = Review.create(restaurant_id: 1, user_id: 1, comments: 'bad', rating: 0)
  end
end
