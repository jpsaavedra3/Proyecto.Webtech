class ListingsController < ApplicationController
  def index
    @listings = Listing.published.with_attached_photos.includes(property: :neighborhood).order(:available_from)
  end

  def show
    @listing = Listing.find(params[:id])
  end
end
