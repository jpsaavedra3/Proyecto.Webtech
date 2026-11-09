class ReportPolicy < ApplicationPolicy
  def index? = moderator?
  def show? = moderator?

  def create? = signed_in?
  def resolve? = moderator?
  def dismiss? = moderator?

  class Scope < ApplicationPolicy::Scope
    def resolve
      user&.moderator? ? scope.all : scope.none
    end
  end
end
