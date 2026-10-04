class Visit < ApplicationRecord
  belongs_to :application
  has_one :review

  enum :status, { proposed: 0, confirmed: 1, cancelled: 2, completed: 3 }

  validates :scheduled_at, presence: true
  validate :scheduled_after_application

  private

  def scheduled_after_application
    return if scheduled_at.blank? || application.blank?

    if scheduled_at <= application.created_at
      errors.add(:scheduled_at, "must be after the application was sent")
    end
  end
end