class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params)
    @restaurant.update_rating
    redirect_to restaurant_path(@restaurant.id)
  end

private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
