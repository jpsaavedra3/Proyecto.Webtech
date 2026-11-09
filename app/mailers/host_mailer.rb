class HostMailer < ApplicationMailer
  # Tells the host that somebody applied to one of their rooms.
  def new_application
    @application = params[:application]
    @listing = @application.listing
    @host = @listing.property.user
    mail to: @host.email_address, subject: "New application for your room in #{@listing.property.neighborhood.name}"
  end
end
