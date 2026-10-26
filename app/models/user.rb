class User < ApplicationRecord
  has_many :properties
  has_many :listings, through: :properties
  has_many :received_applications, through: :listings, source: :applications
  has_many :applications
  has_many :reviews
  has_many :reports
  has_many :saved_listings
  has_many :favorite_listings, through: :saved_listings, source: :listing

  enum :role, { member: 0, moderator: 1 }

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true

  # A completed visit of this user to the property that has not been reviewed yet.
  def reviewable_visit_for(property)
    Visit.completed.where.missing(:review)
         .where(application: applications.where(listing: property.listings)).first
  end
end
