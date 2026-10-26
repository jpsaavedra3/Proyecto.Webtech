class Review < ApplicationRecord
  belongs_to :visit
  belongs_to :property
  belongs_to :user

  validates :comment, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :visit_id, uniqueness: true
  validate :visit_must_be_completed

  private

  def visit_must_be_completed
    errors.add(:visit, "must be completed before writing a review") unless visit&.completed?
  end
end
