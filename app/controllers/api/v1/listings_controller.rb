module Api
  module V1
    # Public, read-only API. It only returns published rooms and never personal data
    # (no host, no address, no applications).
    class ListingsController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound do
        render json: { error: "Listing not found" }, status: :not_found
      end

      # GET /api/v1/listings?neighborhood_id=1&max_rent=400000&available_from=2026-12-01
      def index
        listings = Listing.published.with_attached_photos.includes(property: :neighborhood).order(:available_from)
        if params[:neighborhood_id].present?
          listings = listings.where(property: Property.where(neighborhood_id: Integer(params[:neighborhood_id])))
        end
        listings = listings.rent_up_to(Integer(params[:max_rent])) if params[:max_rent].present?
        listings = listings.available_by(Date.iso8601(params[:available_from])) if params[:available_from].present?

        render json: { data: listings.map { |listing| listing_json(listing) }, meta: { count: listings.size } }
      rescue ArgumentError
        render json: { error: "Invalid filter: neighborhood_id and max_rent must be numbers and available_from a date (YYYY-MM-DD)" },
               status: :bad_request
      end

      # GET /api/v1/listings/:id
      def show
        listing = Listing.published.find(params[:id])
        render json: { data: listing_json(listing).merge(
          description: listing.description.to_plain_text,
          house_rules: listing.house_rules.to_plain_text,
          bedrooms: listing.property.bedrooms,
          bathrooms: listing.property.bathrooms,
          amenities: listing.property.amenities.order(:name).pluck(:name)
        ) }
      end

      private

      def listing_json(listing)
        {
          id: listing.id,
          monthly_rent: listing.monthly_rent.to_i,
          deposit: listing.deposit.to_i,
          available_from: listing.available_from,
          minimum_stay_months: listing.minimum_stay_months,
          furnished: listing.furnished,
          private_bathroom: listing.private_bathroom,
          property_type: listing.property.property_type,
          neighborhood: { id: listing.property.neighborhood.id, name: listing.property.neighborhood.name },
          photo_url: (url_for(listing.photos.first.variant(resize_to_fill: [ 600, 400 ])) if listing.photos.attached?),
          url: listing_url(listing)
        }
      end
    end
  end
end
