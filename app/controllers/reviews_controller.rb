class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review(review_params, current_user)
    if @review.save
      redirect_to restaurant_path(params[:restaurant_id])
    else
      if @review.errors[:user]
        redirect_to restaurant_path(params[:restaurant_id]), alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  def edit
		@review = Review.find(params[:id])
    @restaurant = @review.restaurant
		if @review.user != current_user
			redirect_to restaurant_review_path(@review.id)
		end
	end

	def update
		@review = Review.find(params[:id])
    @restaurant = @review.restaurant
		if @review.user == current_user
		  @review.update(review_params)
			flash[:notice] = "#{@restaurant.name} has been updated"
		else
			flash[:notice] = "You do not have permission to edit this restaurant"
		end
	 redirect_to restaurant_path(@review.restaurant.id)
	end


	def destroy
	 review = Review.find(params[:id])
		if review.user == current_user
			review.destroy
			flash[:notice] = "Your review has been deleted"
		else
			flash[:notice] = "You do not have permission to delete this review"
		end
    redirect_to restaurant_path(review.restaurant.id)
	end

  private
	def review_params
		params.require(:review).permit(:comments, :rating)
	end
end
