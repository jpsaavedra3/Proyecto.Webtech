class ListingsController < ApplicationController
  allow_unauthenticated_access only: [ :index, :show ]
  before_action :set_listing, only: [ :show, :edit, :update, :destroy, :publish, :withdraw, :mark_rented ]

  # The rooms are loaded by search_controller.js from the API.
  def index
    @neighborhoods = Neighborhood.order(:name)
  end

  def show
    @application = @listing.applications.find_by(user: current_user) || Application.new
  end

  def new
    @property = Property.find(params[:property_id])
    @listing = @property.listings.new
    authorize @listing
  end

  def create
    @property = Property.find(params[:property_id])
    @listing = @property.listings.new(listing_params)
    authorize @listing
    if @listing.save
      redirect_to @listing, notice: "Room created as a draft. Publish it when it is ready."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Room updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @listing.destroy
      redirect_to @listing.property, notice: "Room deleted.", status: :see_other
    else
      redirect_to @listing, alert: @listing.errors.full_messages.to_sentence, status: :see_other
    end
  end

  def publish
    change_status(@listing.publish, "The room is now published.", "Only a draft can be published.")
  end

  def withdraw
    change_status(@listing.withdraw, "The room was withdrawn.", "This room cannot be withdrawn.")
  end

  def mark_rented
    change_status(@listing.mark_rented, "The room is marked as rented.", "Only a reserved room can be marked as rented.")
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
    authorize @listing
  end

  def listing_params
    params.expect(listing: [ :monthly_rent, :deposit, :available_from, :minimum_stay_months, :furnished,
                             :private_bathroom, :description, :house_rules, photos: [] ])
  end

  def change_status(changed, notice, alert)
    if changed
      redirect_to @listing, notice: notice, status: :see_other
    else
      redirect_to @listing, alert: alert, status: :see_other
    end
  end
end
