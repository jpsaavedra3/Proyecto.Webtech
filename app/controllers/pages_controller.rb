class PagesController < ApplicationController
  def home
    @featured_listings = Listing.published.with_attached_photos.includes(property: :neighborhood).order(:available_from).limit(3)
  end
end
