class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  def calculate_average
    self.reviews.average(:rating)
  end

  def update_rating
    self.update(rating: calculate_average)
  end
end
