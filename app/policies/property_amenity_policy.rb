class PropertyAmenityPolicy < ApplicationPolicy
  def create?
    signed_in? &&
      (moderator? || record.property.user_id == user.id)
  end

  def update? = create?
  def destroy? = create?

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none unless user
      return scope.all if user.moderator?

      scope.joins(:property)
           .where(properties: { user_id: user.id })
    end
  end
end
