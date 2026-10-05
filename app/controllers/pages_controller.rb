class PagesController < ApplicationController
  def home
    @featured_listings = Listing.published.includes(:listing_photos, property: :neighborhood).order(:available_from).limit(3)
  end
end
