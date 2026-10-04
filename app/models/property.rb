class Property < ApplicationRecord
  belongs_to :user
  belongs_to :neighborhood
  has_many :listings
  has_many :reviews
  has_many :property_amenities
  has_many :amenities, through: :property_amenities
end