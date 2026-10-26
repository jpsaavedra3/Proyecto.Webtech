class AmenitiesController < ApplicationController
  before_action :set_amenity, only: %i[edit update destroy]

  def index
    @amenities = Amenity.order(:name)
  end

  def new
    @amenity = Amenity.new
  end

  def create
    @amenity = Amenity.new(amenity_params)

    if @amenity.save
      redirect_to amenities_path,
                  notice: "Amenity created successfully.",
                  status: :see_other
    else
      flash.now[:alert] = "Could not create amenity."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @amenity.update(amenity_params)
      redirect_to amenities_path,
                  notice: "Amenity updated successfully.",
                  status: :see_other
    else
      flash.now[:alert] = "Could not update amenity."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @amenity.destroy
      redirect_to amenities_path,
                  notice: "Amenity deleted successfully.",
                  status: :see_other
    else
      redirect_to amenities_path,
                  alert: @amenity.errors.full_messages.to_sentence,
                  status: :see_other
    end
  end

  private

  def set_amenity
    @amenity = Amenity.find(params[:id])
  end

  def amenity_params
    params.require(:amenity).permit(:name)
  end
end