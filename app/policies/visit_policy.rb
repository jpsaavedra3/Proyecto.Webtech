class VisitPolicy < ApplicationPolicy
  # The host of the room or the applicant.
  def create?
    host? || applicant?
  end

  def update?
    create?
  end

  def confirm?
    create?
  end

  def cancel?
    create?
  end

  # Only the host marks that the visit happened.
  def complete?
    host?
  end

  private

  def applicant?
    user.present? && record.application.user_id == user.id
  end

  def host?
    user.present? && record.application.listing.property.user_id == user.id
  end
end
