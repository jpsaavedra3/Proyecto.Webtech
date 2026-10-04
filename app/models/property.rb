class Property < ApplicationRecord
  belongs_to :user
  belongs_to :neighborhood
  has_many :listings
  has_many :reviews
  has_many :property_amenities
  has_many :amenities, through: :property_amenities

  validates :address, presence: true
  validates :property_type, inclusion: { in: %w[apartment house] }
  validates :bedrooms, :bathrooms, numericality: { only_integer: true, greater_than: 0 }
end