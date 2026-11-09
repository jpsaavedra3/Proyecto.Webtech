class ReviewPolicy < ApplicationPolicy
  # Only after the author's own completed visit to this property.
  def create?
    visit = record.visit
    signed_in? && visit.present? && visit.completed? && visit.application.user_id == user.id &&
      visit.application.listing.property_id == record.property_id
  end

  def update?
    author?
  end

  def destroy?
    author? || moderator?
  end

  private

  def author?
    user.present? && record.user_id == user.id
  end
end
