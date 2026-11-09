class ReportsController < ApplicationController
  before_action :set_report, only: %i[resolve dismiss]

  def index
    authorize Report
    @reports = policy_scope(Report)
                 .includes(:user, :listing)
                 .order(created_at: :desc)
  end

  def create
    @listing = Listing.find(params[:listing_id])

    @report = @listing.reports.build(
      report_params
    )
    @report.user = current_user
    @report.status = :pending

    authorize @report

    if @report.save
      redirect_to listing_path(@listing),
                  notice: "Report submitted.",
                  status: :see_other
    else
      redirect_to listing_path(@listing),
                  alert: @report.errors.full_messages.to_sentence,
                  status: :see_other
    end
  end

  def resolve
    authorize @report, :resolve?
    @report.resolved!

    redirect_to reports_path,
                notice: "Report resolved.",
                status: :see_other
  end

  def dismiss
    authorize @report, :dismiss?
    @report.dismissed!

    redirect_to reports_path,
                notice: "Report dismissed.",
                status: :see_other
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:reason)
  end
end
