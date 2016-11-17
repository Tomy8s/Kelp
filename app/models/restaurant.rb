class Restaurant < ApplicationRecord
  has_many :reviews, -> { extending WithUserAssociationExtension }, dependent: :destroy
  belongs_to :user

  validates :name, length: { minimum: 3 }, uniqueness: true

  def build_review(attributes={}, user)
    attributes[:user] ||= user
    reviews.new(attributes)
  end

  def calculate_average_rating
    self.reviews.average(:rating).to_f.round(1)
  end

  def update_rating
    self.update(rating: calculate_average_rating)
  end
end
