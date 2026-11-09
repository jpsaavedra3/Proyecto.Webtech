# Policy of the Application model (an application to a room).
# It cannot be called ApplicationPolicy, because that is the base policy.
class RoomApplicationPolicy < ApplicationPolicy
  # The applications a person may see: the ones they wrote and the ones on their rooms.
  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none unless user
      return scope.all if user.moderator?

      scope.where(user: user).or(scope.where(listing: user.listings))
    end
  end

  def index?
    signed_in?
  end

  def show?
    applicant? || host? || moderator?
  end

  # Anyone signed in, except on their own room.
  def create?
    signed_in? && !host?
  end

  def withdraw?
    applicant?
  end

  # Only the host answers.
  def shortlist?
    host?
  end

  def reject?
    host?
  end

  def accept?
    host?
  end

  private

  def applicant?
    user.present? && record.user_id == user.id
  end

  def host?
    user.present? && record.listing.property.user_id == user.id
  end
end
