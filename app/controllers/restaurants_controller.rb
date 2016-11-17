class RestaurantsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	def index
		@restaurants = Restaurant.all
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = current_user.restaurants.new(restaurant_params)
		if @restaurant.save
			redirect_to restaurants_path
		else
			render 'new'
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
		@reviews = @restaurant.reviews
	end

	def edit
		@restaurant = Restaurant.find(params[:id])
		if @restaurant.user != current_user
			redirect_to restaurant_path(@restaurant.id)
		end
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		if @restaurant.user == current_user
		  @restaurant.update(restaurant_params)
			flash[:notice] = "#{@restaurant.name} has been updated"
		else
			flash[:notice] = "You do not have permission to edit this restaurant"
		end
	 redirect_to restaurant_path(@restaurant.id)
	end


	def destroy
	 restaurant = Restaurant.find(params[:id])
		if restaurant.user == current_user
			restaurant.destroy
			flash[:notice] = "#{restaurant.name} has been deleted"
			redirect_to restaurants_path
		else
			flash[:notice] = "You do not have permission to delete this restaurant"
			redirect_to restaurant_path(restaurant.id)
		end
	end

	private
	
	def restaurant_params
		params.require(:restaurant).permit(:name, :description, :rating)
	end
end
