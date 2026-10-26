class NeighborhoodsController < ApplicationController
  def index
    @neighborhoods = Neighborhood.includes(:properties).order(:name)
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
    @listings = @neighborhood.listings.published.with_attached_photos.includes(property: :neighborhood)
  end
end
