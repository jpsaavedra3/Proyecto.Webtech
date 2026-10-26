
require "test_helper"

class AmenitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @amenity = Amenity.create!(name: "Test WiFi")
  end

  test "index is accessible" do
    get amenities_url
    assert_response :success
  end

  test "new and edit forms are accessible" do
    get new_amenity_url
    assert_response :success

    get edit_amenity_url(@amenity)
    assert_response :success
  end

  test "creates amenity" do
    assert_difference("Amenity.count", 1) do
      post amenities_url,
           params: { amenity: { name: "Test Parking" } }
    end

    assert_redirected_to amenities_url
  end

  test "rejects invalid amenity" do
    assert_no_difference("Amenity.count") do
      post amenities_url,
           params: { amenity: { name: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "updates amenity" do
    patch amenity_url(@amenity),
          params: { amenity: { name: "Updated WiFi" } }

    assert_redirected_to amenities_url
    assert_equal "Updated WiFi", @amenity.reload.name
  end

  test "deletes amenity" do
    assert_difference("Amenity.count", -1) do
      delete amenity_url(@amenity)
    end

    assert_redirected_to amenities_url
  end
end
