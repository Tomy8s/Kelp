class Review < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
  validates :rating, inclusion: 0..5
end
