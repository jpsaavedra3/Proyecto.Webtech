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
miguel = User.create!(name: "Miguel Cervantes", email_address: "mcervantes1@example.com", role: :member)
tomas = User.create!(name: "Tomás Rivas", email_address: "trivas1@example.com", role: :member)
cata = User.create!(name: "Cata Perez", email_address: "cperez1@example.com", role: :member)
diego = User.create!(name: "Diego Ortuzar", email_address: "dortuzar1@example.com", role: :moderator)

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
  user: diego,
  neighborhood: providencia,
  address: "Av. Manuel Montt 1234",
  property_type: "apartment",
  bedrooms: 3,
  bathrooms: 2,
  shared_spaces: "Living room, kitchen and balcony"
)

property2 = Property.create!(
  user: cata,
  neighborhood: nunoa,
  address: "Av. Irarrázaval 5678",
  property_type: "apartment",
  bedrooms: 2,
  bathrooms: 1,
  shared_spaces: "Living room and kitchen"
)

property3 = Property.create!(
  user: diego,
  neighborhood: las_condes,
  address: "Av. Presidente Kennedy 9167",
  property_type: "house",
  bedrooms: 4,
  bathrooms: 3,
  shared_spaces: "Living room, kitchen, dining room and backyard"
)

puts "Creating property amenities..."
property1.amenities << [ wifi, laundry, parking ]
property2.amenities << [ wifi, laundry ]
property3.amenities << [ wifi, laundry, gym, pool, parking ]

puts "Creating listings..."
listing1 = Listing.create!(
  property: property1,
  monthly_rent: 450_000,
  deposit: 450_000,
  available_from: Date.current + 30.days,
  minimum_stay_months: 6,
  furnished: true,
  private_bathroom: true,
  description: "Large bedroom with a private bathroom and a window facing the street, five minutes from Manuel Montt station.",
  house_rules: "No smoking, no pets, no parties.",
  status: :published
)

listing2 = Listing.create!(
  property: property1,
  monthly_rent: 380_000,
  deposit: 380_000,
  available_from: Date.current + 15.days,
  minimum_stay_months: 3,
  furnished: true,
  private_bathroom: false,
  description: "Smaller bedroom next to the balcony. The bathroom is shared with one other housemate.",
  house_rules: "No smoking, no pets, no parties.",
  status: :published
)

listing3 = Listing.create!(
  property: property2,
  monthly_rent: 340_000,
  deposit: 340_000,
  available_from: Date.current + 10.days,
  minimum_stay_months: 3,
  furnished: false,
  private_bathroom: true,
  description: "Unfurnished bedroom in Ñuñoa, close to Plaza Ñuñoa and the metro line 3.",
  house_rules: "No smoking, no pets, no parties.",
  status: :published
)

listing4 = Listing.create!(
  property: property2,
  monthly_rent: 360_000,
  deposit: 360_000,
  available_from: Date.current + 20.days,
  minimum_stay_months: 3,
  furnished: false,
  private_bathroom: true,
  description: "Quiet bedroom at the back of the apartment, with its own bathroom and lots of storage.",
  house_rules: "No smoking, no pets, no parties.",
  status: :reserved
)

listing5 = Listing.create!(
  property: property3,
  monthly_rent: 600_000,
  deposit: 600_000,
  available_from: Date.current - 60.days,
  minimum_stay_months: 12,
  furnished: true,
  private_bathroom: true,
  description: "Main bedroom of the house, with a private bathroom and a view of the backyard.",
  house_rules: "No noise after 10 PM on weekdays and 2 AM on weekends.",
  status: :rented
)

listing6 = Listing.create!(
  property: property3,
  monthly_rent: 520_000,
  deposit: 520_000,
  available_from: Date.current + 45.days,
  minimum_stay_months: 12,
  furnished: true,
  private_bathroom: false,
  description: "Bedroom on the second floor, next to the gym room.",
  house_rules: "No noise after 10 PM on weekdays and 2 AM on weekends.",
  status: :withdrawn
)

puts "Creating listing photos..."
ListingPhoto.create!(listing: listing1, url: "room-1.jpg")
ListingPhoto.create!(listing: listing2, url: "room-2.jpg")
ListingPhoto.create!(listing: listing3, url: "room-3.jpg")
ListingPhoto.create!(listing: listing4, url: "room-2.jpg")
ListingPhoto.create!(listing: listing5, url: "room-3.jpg")
ListingPhoto.create!(listing: listing6, url: "room-1.jpg")


puts "Creating more published listings..."
property4 = Property.create!(
  user: miguel,
  neighborhood: nunoa,
  address: "Dublé Almeyda 2950",
  property_type: "house",
  bedrooms: 3,
  bathrooms: 2,
  shared_spaces: "Living room, kitchen and a small garden"
)
property4.amenities << [ wifi, parking ]

listing7 = Listing.create!(
  property: property3,
  monthly_rent: 550_000,
  deposit: 550_000,
  available_from: Date.current + 25.days,
  minimum_stay_months: 12,
  furnished: true,
  private_bathroom: true,
  description: "Third bedroom of the house, facing the pool, with its own bathroom.",
  house_rules: "No noise after 10 PM on weekdays and 2 AM on weekends.",
  status: :published
)

listing8 = Listing.create!(
  property: property4,
  monthly_rent: 300_000,
  deposit: 300_000,
  available_from: Date.current + 7.days,
  minimum_stay_months: 6,
  furnished: false,
  private_bathroom: false,
  description: "Bright bedroom on the first floor of a quiet house, ten minutes walking from Plaza Ñuñoa.",
  house_rules: "No smoking indoors. Pets are welcome.",
  status: :published
)

ListingPhoto.create!(listing: listing7, url: "room-1.jpg")
ListingPhoto.create!(listing: listing8, url: "room-3.jpg")


listing9 = Listing.create!(
  property: property4,
  monthly_rent: 280_000,
  deposit: 280_000,
  available_from: Date.current + 40.days,
  minimum_stay_months: 6,
  furnished: false,
  private_bathroom: false,
  description: "Small bedroom next to the kitchen. The host is still writing the details.",
  house_rules: "No smoking indoors. Pets are welcome.",
  status: :draft
)
ListingPhoto.create!(listing: listing9, url: "room-2.jpg")

puts "Creating applications..."
# listing1: three applications competing for the same room
Application.create!(
  listing: listing1,
  user: miguel,
  message: "I am interested in this place because it is close to my university and has everything I need.",
  move_in_date: Date.current + 35.days,
  intended_stay_months: 12,
  status: :pending
)

application2 = Application.create!(
  listing: listing1,
  user: tomas,
  message: "I am looking for a furnished place in Providencia for the next academic year.",
  move_in_date: Date.current + 40.days,
  intended_stay_months: 10,
  status: :shortlisted
)

application3 = Application.create!(
  listing: listing1,
  user: cata,
  message: "I am looking for a long-term place with good access to public transportation.",
  move_in_date: Date.current + 45.days,
  intended_stay_months: 12,
  status: :rejected
)

# listing2: one withdrawn, one shortlisted
Application.create!(
  listing: listing2,
  user: miguel,
  message: "The location and minimum stay work well for what I am looking for.",
  move_in_date: Date.current + 20.days,
  intended_stay_months: 6,
  status: :withdrawn
)

application5 = Application.create!(
  listing: listing2,
  user: cata,
  message: "I work near Manuel Montt and would like to stop commuting from Maipú.",
  move_in_date: Date.current + 20.days,
  intended_stay_months: 6,
  status: :shortlisted
)

# listing4: one accepted, the other rejected when the host chose
application6 = Application.create!(
  listing: listing4,
  user: tomas,
  message: "I am interested in living in Ñuñoa and this room fits what I am looking for.",
  move_in_date: Date.current + 25.days,
  intended_stay_months: 12,
  status: :accepted,
  created_at: 20.days.ago
)

application7 = Application.create!(
  listing: listing4,
  user: miguel,
  message: "I would like a room with a private bathroom close to the metro.",
  move_in_date: Date.current + 25.days,
  intended_stay_months: 6,
  status: :rejected,
  created_at: 25.days.ago
)

puts "Creating visits..."
Visit.create!(application: application2, scheduled_at: 3.days.from_now, status: :proposed)
Visit.create!(application: application5, scheduled_at: 4.days.from_now, status: :confirmed)
Visit.create!(application: application3, scheduled_at: 2.days.from_now, status: :cancelled)
visit_tomas = Visit.create!(application: application6, scheduled_at: 10.days.ago, status: :completed)
visit_miguel = Visit.create!(application: application7, scheduled_at: 12.days.ago, status: :completed)

puts "Creating reviews..."
Review.create!(
  visit: visit_tomas,
  property: property2,
  user: tomas,
  rating: 4,
  comment: "The apartment was exactly as in the photos and the host answered every question."
)

Review.create!(
  visit: visit_miguel,
  property: property2,
  user: miguel,
  rating: 3,
  comment: "Nice room, but the street is noisier than the listing says."
)

puts "Creating saved listings..."
miguel.favorite_listings << [ listing1, listing4 ]
tomas.favorite_listings << listing1
cata.favorite_listings << listing5

puts "Creating reports..."
Report.create!(user: miguel, listing: listing6, reason: "The photos do not match the room described.", status: :resolved)
Report.create!(user: tomas, listing: listing2, reason: "Some of the information in the listing is inaccurate.", status: :pending)
Report.create!(user: cata, listing: listing5, reason: "The listing may contain misleading information.", status: :dismissed)

puts "Done: #{User.count} users, #{Property.count} properties, #{Listing.count} listings, " \
       "#{Application.count} applications, #{Visit.count} visits, #{Review.count} reviews."
