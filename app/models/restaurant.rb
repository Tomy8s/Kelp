class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :name, length: { minimum: 3 }, uniqueness: true

  def build_review(attributes={}, user)
    attributes[:user] ||= user
    reviews.new(attributes)
  end
end
