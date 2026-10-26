class VisitsController < ApplicationController
  before_action :set_visit, only: [ :edit, :update, :confirm, :cancel, :complete ]

  def new
    @application = Application.find(params[:application_id])
    @visit = @application.visits.new
  end

  def create
    @application = Application.find(params[:application_id])
    @visit = @application.visits.new(visit_params)
    if @visit.save
      redirect_to @application, notice: "Visit proposed."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  # Rescheduling: the new date goes back to "proposed" until the applicant confirms it.
  def update
    if @visit.update(visit_params.merge(status: :proposed))
      redirect_to @visit.application, notice: "Visit rescheduled."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def confirm
    change_status(@visit.confirm, "Visit confirmed.")
  end

  def cancel
    change_status(@visit.cancel, "Visit cancelled.")
  end

  def complete
    change_status(@visit.complete, "Visit marked as completed.")
  end

  private

  def set_visit
    @visit = Visit.find(params[:id])
  end

  def visit_params
    params.expect(visit: [ :scheduled_at ])
  end

  def change_status(changed, notice)
    if changed
      redirect_to @visit.application, notice: notice, status: :see_other
    else
      redirect_to @visit.application, alert: "That is not possible for a #{@visit.status} visit.", status: :see_other
    end
  end
end
