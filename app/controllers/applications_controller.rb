class ApplicationsController < ApplicationController
  before_action :set_application, only: [ :show, :withdraw, :shortlist, :reject, :accept ]

  # The host's inbox (applications received on their rooms) and the seeker's list (applications sent).
  def index
    @received = current_user.received_applications.includes(:user, listing: { property: :neighborhood })
                            .order(created_at: :desc)
    @sent = current_user.applications.includes(:user, listing: { property: :neighborhood }).order(created_at: :desc)
    @pending_count = @received.pending.count
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

  def shortlist
    @application.shortlisted! if @application.pending?
    answer
  end

  def reject
    @application.rejected! if @application.open?
    answer
  end

  def accept
    @application.accept!
    answer
  rescue ActiveRecord::RecordInvalid => e
    redirect_to applications_path, alert: e.record.errors.full_messages.to_sentence, status: :see_other
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.expect(application: [ :message, :move_in_date, :intended_stay_months ])
  end

  # Re-renders every row of the room (accepting rejects the others too) and the pending count.
  def answer
    @changed = @application.listing.applications.includes(:user, listing: { property: :neighborhood })
    @pending_count = current_user.received_applications.pending.count
    respond_to do |format|
      format.turbo_stream { render :answer }
      format.html { redirect_to applications_path, status: :see_other }
    end
  end
end
