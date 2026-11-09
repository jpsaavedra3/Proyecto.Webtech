class PropertyPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    signed_in?
  end

  # The owner, or any moderator.
  def update?
    owner? || moderator?
  end

  def destroy?
    update?
  end

  private

  def owner?
    user.present? && record.user_id == user.id
  end
end
