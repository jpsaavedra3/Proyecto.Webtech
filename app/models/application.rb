class Application < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  has_many :visits

  enum :status, { pending: 0, shortlisted: 1, accepted: 2, rejected: 3, withdrawn: 4 }

  validates :message, :move_in_date, presence: true
  validates :intended_stay_months, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, uniqueness: { scope: :listing_id, message: "has already applied to this listing" }
end
