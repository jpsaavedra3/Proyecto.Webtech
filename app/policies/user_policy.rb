class UserPolicy < ApplicationPolicy
  # A member edits only their own profile.
  def update?
    user.present? && record.id == user.id
  end
end
