class Listing < ApplicationRecord
  belongs_to :property
  has_many :listing_photos
  has_many :applications
  has_many :saved_listings
  has_many :reports

  enum :status, { draft: 0, published: 1, reserved: 2, rented: 3, withdrawn: 4 }

  validates :available_from, :description, presence: true
  validates :monthly_rent, numericality: { greater_than: 0 }
  validates :deposit, numericality: { greater_than_or_equal_to: 0 }
  validates :minimum_stay_months, numericality: { only_integer: true, greater_than: 0 }
  validate :available_from_cannot_be_in_the_past

  private

  def available_from_cannot_be_in_the_past
    return if available_from.blank?
    return unless available_from_changed? && (draft? || published?)

    if available_from < Date.current
      errors.add(:available_from, "can't be in the past")
    end
  end
end