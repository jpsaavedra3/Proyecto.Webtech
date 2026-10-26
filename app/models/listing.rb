class Listing < ApplicationRecord
  belongs_to :property
  has_many :applications, dependent: :restrict_with_error
  has_many :saved_listings, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many_attached :photos
  has_rich_text :description
  has_rich_text :house_rules

  # the enum also creates Listing.published, Listing.draft, etc.
  enum :status, { draft: 0, published: 1, reserved: 2, rented: 3, withdrawn: 4 }
  scope :available_by, ->(date) { where("available_from <= ?", date) }
  scope :rent_up_to, ->(amount) { where("monthly_rent <= ?", amount) }

  validates :available_from, :description, presence: true
  validates :monthly_rent, numericality: { greater_than: 0 }
  validates :deposit, numericality: { greater_than_or_equal_to: 0 }
  validates :minimum_stay_months, numericality: { only_integer: true, greater_than: 0 }
  validate :available_from_cannot_be_in_the_past
  validate :photos_must_be_images

  # The host publishes a draft.
  def publish
    return false unless draft?

    published!
  end

  # The host or a moderator takes the listing down: every open application is rejected with it.
  def withdraw
    return false if withdrawn? || rented?

    transaction do
      applications.where(status: [ :pending, :shortlisted ]).find_each(&:rejected!)
      withdrawn!
    end
  end

  # The new housemate moved in.
  def mark_rented
    return false unless reserved?

    rented!
  end

  private

  def available_from_cannot_be_in_the_past
    return if available_from.blank?
    return unless available_from_changed? && (draft? || published?)

    if available_from < Date.current
      errors.add(:available_from, "can't be in the past")
    end
  end

  def photos_must_be_images
    photos.each do |photo|
      unless photo.content_type.in?(%w[image/jpeg image/png image/webp])
        errors.add(:photos, "must be JPEG, PNG or WebP images")
      end
      if photo.byte_size > 5.megabytes
        errors.add(:photos, "must be smaller than 5 MB each")
      end
    end
  end
end
