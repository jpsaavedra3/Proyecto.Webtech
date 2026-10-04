class User < ApplicationRecord
  has_many :properties
  has_many :applications
  has_many :reviews
  has_many :reports
  has_many :saved_listings
  has_many :favorite_listings, through: :saved_listings, source: :listing

  enum :role, { member: 0, moderator: 1 }

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
end
