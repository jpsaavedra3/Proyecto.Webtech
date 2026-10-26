class Application < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  has_many :visits

  enum :status, { pending: 0, shortlisted: 1, accepted: 2, rejected: 3, withdrawn: 4 }

  validates :message, :move_in_date, presence: true
  validates :intended_stay_months, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, uniqueness: { scope: :listing_id, message: "has already applied to this listing" }
  validate :listing_must_be_published, on: :create
  validate :applicant_cannot_be_the_host, on: :create
  validate :only_one_accepted_per_listing, if: :accepted?

  def open?
    pending? || shortlisted?
  end

  def withdraw_by(person)
    return false unless person == user && open?

    withdrawn!
  end

  def accept!
    transaction do
      unless open? && listing.published?
        errors.add(:base, "Only an open application on a published listing can be accepted")
        raise ActiveRecord::RecordInvalid, self
      end

      listing.applications.where(status: [ :pending, :shortlisted ]).where.not(id: id).find_each(&:rejected!)
      accepted!
      listing.reserved!
    end
  end

  private

  def listing_must_be_published
    errors.add(:listing, "is not accepting applications") unless listing&.published?
  end

  def applicant_cannot_be_the_host
    errors.add(:base, "You cannot apply to your own room") if listing && listing.property.user_id == user_id
  end

  def only_one_accepted_per_listing
    if listing.applications.accepted.where.not(id: id).exists?
      errors.add(:status, "cannot be accepted: the room already has an accepted application")
    end
  end
end
