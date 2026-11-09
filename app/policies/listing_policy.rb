class ListingPolicy < ApplicationPolicy
  # Visitors see published rooms; a member also sees their own; a moderator sees everything.
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user&.moderator?
        scope.all
      elsif user
        scope.published.or(scope.where(property: user.properties))
      else
        scope.published
      end
    end
  end

  def index?
    true
  end

  # A draft only for its host and moderators.
  def show?
    !record.draft? || host? || moderator?
  end

  def create?
    host? || moderator?
  end

  def update?
    host? || moderator?
  end

  def destroy?
    update?
  end

  def publish?
    update?
  end

  def withdraw?
    update?
  end

  def mark_rented?
    update?
  end

  private

  def host?
    user.present? && record.property.user_id == user.id
  end
end
