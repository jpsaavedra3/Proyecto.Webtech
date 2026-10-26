class PropertiesController < ApplicationController
  def index
    @properties = Property.includes(:neighborhood, :listings).order(:address)
  end

  def show
    @property = Property.find(params[:id])
    @listings = @property.listings.published.with_attached_photos.includes(property: :neighborhood)
  end
end
