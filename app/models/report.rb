class Report < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  enum :status, { pending: 0, resolved: 1, dismissed: 2 }

  validates :reason, presence: true
end
