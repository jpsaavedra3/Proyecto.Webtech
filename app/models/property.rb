class Property < ApplicationRecord
  TYPES = %w[apartment house].freeze

  belongs_to :user
  belongs_to :neighborhood
  has_many :listings, dependent: :restrict_with_error
  has_many :reviews, dependent: :restrict_with_error
  has_many :property_amenities, dependent: :destroy
  has_many :amenities, through: :property_amenities

  validates :address, presence: true
  validates :property_type, inclusion: { in: TYPES }
  validates :bedrooms, :bathrooms, numericality: { only_integer: true, greater_than: 0 }
end
