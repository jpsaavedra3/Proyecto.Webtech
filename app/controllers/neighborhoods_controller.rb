class NeighborhoodsController < ApplicationController
  allow_unauthenticated_access only: [ :index, :show ]
  before_action :set_neighborhood, only: %i[show edit update destroy]

  def index
    authorize Neighborhood
    @neighborhoods = policy_scope(Neighborhood).includes(:properties).order(:name)
  end

  def show
    @listings = @neighborhood.listings
                             .published
                             .includes(property: :neighborhood)
    authorize @neighborhood
  end

  def new
    @neighborhood = Neighborhood.new
    authorize @neighborhood
  end

  def create
    @neighborhood = Neighborhood.new(neighborhood_params)
    authorize @neighborhood

    if @neighborhood.save
      redirect_to neighborhoods_path,
                  notice: "Neighborhood created successfully.",
                  status: :see_other
    else
      flash.now[:alert] = "Could not create neighborhood."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @neighborhood
  end

  def update
    authorize @neighborhood
    if @neighborhood.update(neighborhood_params)
      redirect_to neighborhoods_path,
                  notice: "Neighborhood updated successfully.",
                  status: :see_other
    else
      flash.now[:alert] = "Could not update neighborhood."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @neighborhood
    if @neighborhood.destroy
      redirect_to neighborhoods_path,
                  notice: "Neighborhood deleted successfully.",
                  status: :see_other
    else
      redirect_to neighborhoods_path,
                  alert: @neighborhood.errors.full_messages.to_sentence,
                  status: :see_other
    end
  end

  private

  def set_neighborhood
    @neighborhood = Neighborhood.find(params[:id])
  end

  def neighborhood_params
    params.require(:neighborhood).permit(:name)
  end
end
