class NeighborhoodsController < ApplicationController
  def index
    @neighborhoods = Neighborhood.includes(:properties).order(:name)
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
    @listings = @neighborhood.listings.published.includes(:listing_photos, property: :neighborhood)
  end
end
