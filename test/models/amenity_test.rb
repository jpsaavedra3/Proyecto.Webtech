
require "test_helper"

class AmenityTest < ActiveSupport::TestCase
  test "requires a name" do
    amenity = Amenity.new(name: "")

    assert_not amenity.valid?
    assert amenity.errors[:name].any?
  end

  test "name must be unique" do
    Amenity.create!(name: "Test Amenity")

    duplicate = Amenity.new(name: "Test Amenity")

    assert_not duplicate.valid?
    assert duplicate.errors[:name].any?
  end

  test "cannot delete amenity with property associations" do
    association = Amenity.reflect_on_association(:property_amenities)

    assert_equal :restrict_with_error,
                 association.options[:dependent]
  end
end
