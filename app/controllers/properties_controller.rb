class PropertiesController < ApplicationController
  before_action :set_property, only: [ :show, :edit, :update, :destroy ]

  def index
    @properties = Property.includes(:neighborhood, :listings).order(:address)
  end

  def show
    @listings = @property.listings.with_attached_photos.includes(property: :neighborhood)
    @listings = @listings.published unless @property.user == current_user
    @reviewable_visit = current_user&.reviewable_visit_for(@property)
  end

  def new
    @property = Property.new
  end

  def create
    @property = current_user.properties.new(property_params)
    if @property.save
      redirect_to @property, notice: "Property created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @property.update(property_params)
      redirect_to @property, notice: "Property updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @property.destroy
      redirect_to properties_path, notice: "Property deleted.", status: :see_other
    else
      redirect_to @property, alert: @property.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.expect(property: [ :neighborhood_id, :address, :property_type, :bedrooms, :bathrooms, :shared_spaces,
                              amenity_ids: [] ])
  end
end
