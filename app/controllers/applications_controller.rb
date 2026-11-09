class ApplicationsController < ApplicationController
  before_action :set_application, only: [ :show, :withdraw, :shortlist, :reject, :accept ]

  # The host's inbox and the seeker's list are built from the policy scope,
  # so the query only returns applications the current user may see.
  def index
    applications = policy_scope(Application).includes(:user, listing: { property: :neighborhood })
                                            .order(created_at: :desc)
    @received = applications.where(listing: current_user.listings)
    @sent = applications.where(user: current_user)
    @pending_count = @received.pending.count
  end

  def show
    @visits = @application.visits.order(:scheduled_at)
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @application = @listing.applications.new(application_params)
    @application.user = current_user
    authorize @application
    if @application.save
      HostMailer.with(application: @application).new_application.deliver_later
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

  # Typing the id of somebody else's application in the URL ends on the "not allowed" page.
  def set_application
    @application = Application.find(params[:id])
    authorize @application
  end

  def application_params
    params.expect(application: [ :message, :move_in_date, :intended_stay_months ])
  end

  # Re-renders every row of the room (accepting rejects the others too) and the pending count.
  def answer
    @changed = @application.listing.applications.includes(:user, listing: { property: :neighborhood })
    @pending_count = policy_scope(Application).where(listing: current_user.listings).pending.count
    respond_to do |format|
      format.turbo_stream { render :answer }
      format.html { redirect_to applications_path, status: :see_other }
    end
  end
end
