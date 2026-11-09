class SavedListingPolicy < ApplicationPolicy
  def index? = signed_in?

  def show?
    signed_in? && record.user_id == user.id
  end

  def create?
    signed_in? && record.user_id == user.id
  end

  def destroy? = show?

  class Scope < ApplicationPolicy::Scope
    def resolve
      user ? scope.where(user_id: user.id) : scope.none
    end
  end
end
