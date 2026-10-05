# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning up database..."

Report.destroy_all
SavedListing.destroy_all
Review.destroy_all
Visit.destroy_all
Application.destroy_all
ListingPhoto.destroy_all
Listing.destroy_all
PropertyAmenity.destroy_all
Property.destroy_all
Amenity.destroy_all
Neighborhood.destroy_all
User.destroy_all

puts "Creating users..."
    Miguel = User.create!(
    name: "Miguel Cervantes",
    email_address: "mcervantes1@example.com",
    role: 0
    )

    John = User.create!(
        name: "John Doe",
        email_address: "jdoe1@example.com",
        role: 0
    )

    Cata = User.create!(
        name: "Cata Perez",
        email_address: "cperez1@example.com",
        role: 0
    )

    Diego = User.create!(
        name: "Diego Ortuzar",
        email_address: "dortuzar1@example.com",
        role: 1
    )

puts "Creating neighborhoods..."
    providencia = Neighborhood.create!(name: "Providencia")
    nunoa = Neighborhood.create!(name: "Ñuñoa")
    las_condes = Neighborhood.create!(name: "Las Condes")

puts "Creating amenities..."
    wifi = Amenity.create!(name: "Wi-Fi")
    laundry = Amenity.create!(name: "Laundry")
    gym = Amenity.create!(name: "Gym")
    pool = Amenity.create!(name: "Pool")
    parking = Amenity.create!(name: "Parking")

puts "Creating properties..."
    property1 = Property.create!(
        user: Diego,
        neighborhood: providencia,
        address: "Av. Manuel Montt 1234",
        property_type: "apartment",
        bedrooms: 3,
        bathrooms: 2,
        shared_spaces: "Living room, kitchen and balcony"
    )

    property2 = Property.create!(
        user: Cata,
        neighborhood: nunoa,
        address: "Calle Irarrazabal 5678",
        property_type: "apartment",
        bedrooms: 2,
        bathrooms: 1,
        shared_spaces: "Living room and kitchen"
    )

    property3 = Property.create!(
        user: Diego,
        neighborhood: las_condes,
        address: "Av. Presidente Kennedy 9167",
        property_type: "house",
        bedrooms: 4,
        bathrooms: 3,
        shared_spaces: "Living room, kitchen, dining room and backyard"
    )

puts "Creating property amenities..."
    PropertyAmenity.create!(property: property1, amenity: wifi)
    PropertyAmenity.create!(property: property1, amenity: laundry)
    PropertyAmenity.create!(property: property1, amenity: parking)

    PropertyAmenity.create!(property: property2, amenity: wifi)
    PropertyAmenity.create!(property: property2, amenity: laundry)

    PropertyAmenity.create!(property: property3, amenity: wifi)
    PropertyAmenity.create!(property: property3, amenity: laundry)
    PropertyAmenity.create!(property: property3, amenity: gym)
    PropertyAmenity.create!(property: property3, amenity: pool)
    PropertyAmenity.create!(property: property3, amenity: parking)

puts "Creating listings..."
    listing1 = Listing.create!(
    property: property1,
    monthly_rent: 450_000,
    deposit: 900_000,
    available_from: Date.current + 30.days,
    minimum_stay_months: 6,
    furnished: true,
    private_bathroom: true,
    description: "Beautiful apartment in Providencia with great amenities and a spacious layout.",
    house_rules: "No smoking, no pets, no parties.",
    status: 1
    )

    listing2 = Listing.create!(
        property: property1,
        monthly_rent: 430_000,
        deposit: 860_000,
        available_from: Date.current + 15.days,
        minimum_stay_months: 3,
        furnished: true,
        private_bathroom: true,
        description: "Beautiful apartment in Providencia with great amenities and a spacious layout.",
        house_rules: "No smoking, no pets, no parties.",
        status: 1
    )

    listing3 = Listing.create!(
        property: property2,
        monthly_rent: 340_000,
        deposit: 680_000,
        available_from: Date.current + 10.days,
        minimum_stay_months: 3,
        furnished: false,
        private_bathroom: true,
        description: "Cozy apartment in Ñuñoa with a great location and easy access to public transportation.",
        house_rules: "No smoking, no pets, no parties.",
        status: 0
    )

    listing4 = Listing.create!(
        property: property2,
        monthly_rent: 360_000,
        deposit: 720_000,
        available_from: Date.current + 20.days,
        minimum_stay_months: 3,
        furnished: false,
        private_bathroom: true,
        description: "Cozy apartment in Ñuñoa with a great location and easy access to public transportation.",
        house_rules: "No smoking, no pets, no parties.",
        status: 2
    )

    listing5 = Listing.create!(
        property: property3,
        monthly_rent: 800_000,
        deposit: 1_600_000,
        available_from: Date.current + 60.days,
        minimum_stay_months: 12,
        furnished: true,
        private_bathroom: true,
        description: "Spacious house in Las Condes with a beautiful backyard and modern amenities.",
        house_rules: "No noise past 10 PM during week and 2 AM during weekends.",
        status: 3
    )

    listing6 = Listing.create!(
        property: property3,
        monthly_rent: 850_000,
        deposit: 1_700_000,
        available_from: Date.current + 45.days,
        minimum_stay_months: 12,
        furnished: true,
        private_bathroom: true,
        description: "Spacious house in Las Condes with a beautiful backyard and modern amenities.",
        house_rules: "No noise past 10 PM during week and 2 AM during weekends.",
        status: 4
    )

puts "Creating listing photos..."
    ListingPhoto.create!(listing: listing1, url: "app/assets/images/room-1.jpg")
    ListingPhoto.create!(listing: listing2, url: "app/assets/images/room-1.jpg")
    ListingPhoto.create!(listing: listing3, url: "app/assets/images/room-2.jpg")
    ListingPhoto.create!(listing: listing4, url: "app/assets/images/room-2.jpg")
    ListingPhoto.create!(listing: listing5, url: "app/assets/images/room-3.jpg")
    ListingPhoto.create!(listing: listing6, url: "app/assets/images/room-3.jpg")

puts "Creating applications..."
    application1 = Application.create!(
        listing: listing1,
        user: Miguel,
        message: "I am interested in this place because it is close to my university and has everything I need.",
        move_in_date: Date.current + 35.days,
        intended_stay_months: 12,
        status: 0
    )

    application2 = Application.create!(
        listing: listing1,
        user: John,
        message: "I am looking for a furnished place in Providencia for the next academic year.",
        move_in_date: Date.current + 40.days,
        intended_stay_months: 10,
        status: 1
    )

    application3 = Application.create!(
        listing: listing1,
        user: Cata,
        message: "I am looking for a long-term place with good access to public transportation.",
        move_in_date: Date.current + 45.days,
        intended_stay_months: 12,
        status: 3
    )

    application4 = Application.create!(
        listing: listing2,
        user: Miguel,
        message: "The location and minimum stay period work well for what I am looking for.",
        move_in_date: Date.current + 20.days,
        intended_stay_months: 6,
        status: 4
    )

    application5 = Application.create!(
        listing: listing4,
        user: John,
        message: "I am interested in living in Ñuñoa and this property fits what I am looking for.",
        move_in_date: Date.current + 30.days,
        intended_stay_months: 12,
        status: 2
    )

puts "Creating visits..."
    visit1 = Visit.create!(
        application: application1,
        scheduled_at: Date.current + 10.days,
        status: 0
    )

    visit2 = Visit.create!(
        application: application2,
        scheduled_at: Date.current + 12.days,
        status: 1
    )

    visit3 = Visit.create!(
        application: application3,
        scheduled_at: Date.current + 14.days,
        status: 2
    )

    visit4 = Visit.create!(
        application: application5,
        scheduled_at: Date.current + 5.days,
        status: 3
    )

puts "Creating reviews..."
    review1 = Review.create!(
        visit: visit4,
        property: property2,
        user: John,
        rating: 4,
        comment: "The property was well-maintained and the host was very accommodating. I had a pleasant experience."
    )

puts "Creating saved listings..."
    SavedListing.create!(
        user: Miguel,
        listing: listing1
    )

    SavedListing.create!(
        user: Miguel,
        listing: listing4
    )

    SavedListing.create!(
        user: John,
        listing: listing1
    )

    SavedListing.create!(
        user: Cata,
        listing: listing5
    )

puts "Creating reports..."
    Report.create!(
        user: Miguel,
        listing: listing6,
        reason: "The information in this listing appears to be outdated.",
        status: 0
    )

    Report.create!(
        user: John,
        listing: listing3,
        reason: "Some of the information provided in the listing is inaccurate.",
        status: 1
    )

    Report.create!(
        user: Cata,
        listing: listing5,
        reason: "The listing may contain misleading information.",
        status: 2
    )