class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params)
    redirect_to restaurant_path(params[:restaurant_id])
  end

  private
	def review_params
		params.require(:review).permit(:comments, :rating)
	end
end
