class ListingsController < ApplicationController
  def index
    @listings = Listing.published.includes(:listing_photos, property: :neighborhood).order(:available_from)
  end

  def show
    @listing = Listing.find(params[:id])
  end
end
