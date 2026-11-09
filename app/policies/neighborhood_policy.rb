class NeighborhoodPolicy < ApplicationPolicy
  def index?   = true
  def show?    = true
  def create?  = user&.moderator? || false
  def new?     = create?
  def update?  = create?
  def edit?    = update?
  def destroy? = create?

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
