class Visit < ApplicationRecord
  belongs_to :application
  has_one :review

  enum :status, { proposed: 0, confirmed: 1, cancelled: 2, completed: 3 }

  validates :scheduled_at, presence: true
  validate :scheduled_after_application
  validate :application_must_be_shortlisted, on: :create
  validate :cannot_be_scheduled_in_the_past

  # The applicant confirms a proposed visit.
  def confirm
    return false unless proposed?

    confirmed!
  end

  def cancel
    return false unless proposed? || confirmed?

    cancelled!
  end

  # Only a completed visit enables a review.
  def complete
    return false unless confirmed?

    completed!
  end

  private

  def scheduled_after_application
    return if scheduled_at.blank? || application.blank?

    if scheduled_at <= application.created_at
      errors.add(:scheduled_at, "must be after the application was sent")
    end
  end

  def application_must_be_shortlisted
    errors.add(:application, "must be shortlisted before proposing a visit") unless application&.shortlisted?
  end

  def cannot_be_scheduled_in_the_past
    return if scheduled_at.blank? || completed? || cancelled?

    if scheduled_at_changed? && scheduled_at < Time.current
      errors.add(:scheduled_at, "can't be in the past")
    end
  end
end
