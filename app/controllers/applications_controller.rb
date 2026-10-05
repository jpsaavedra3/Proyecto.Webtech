class ApplicationsController < ApplicationController
  def index
    @applications = Application.includes(:user, listing: { property: :neighborhood }).order(created_at: :desc)
    @pending_count = Application.pending.count
  end

  def show
    @application = Application.find(params[:id])
    @visits = @application.visits.order(:scheduled_at)
  end
end
