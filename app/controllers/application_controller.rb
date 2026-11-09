class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  # Public pages skip the sign in, so the session is resumed here too.
  def current_user
    resume_session&.user
  end

  def not_authorized
    render "pages/forbidden", status: :forbidden, formats: :html
  end
end
