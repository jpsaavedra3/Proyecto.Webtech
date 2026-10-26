class ApplicationsController < ApplicationController
  before_action :set_application, only: [ :show, :withdraw ]

  def index
    @applications = Application.includes(:user, listing: { property: :neighborhood }).order(created_at: :desc)
    @pending_count = Application.pending.count
  end

  def show
    @visits = @application.visits.order(:scheduled_at)
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @application = @listing.applications.new(application_params)
    @application.user = current_user
    if @application.save
      redirect_to @listing, status: :see_other
    else
      render partial: "applications/frame", locals: { listing: @listing, application: @application },
             status: :unprocessable_entity
    end
  end

  def withdraw
    if @application.withdraw_by(current_user)
      redirect_to @application.listing, status: :see_other
    else
      redirect_to @application.listing, alert: "This application cannot be withdrawn.", status: :see_other
    end
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.expect(application: [ :message, :move_in_date, :intended_stay_months ])
  end
end
