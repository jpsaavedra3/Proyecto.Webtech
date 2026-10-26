
require "test_helper"

class NeighborhoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @neighborhood = Neighborhood.create!(name: "Test District")
  end

  test "index and show are accessible" do
    get neighborhoods_url
    assert_response :success

    get neighborhood_url(@neighborhood)
    assert_response :success
  end

  test "new and edit forms are accessible" do
    get new_neighborhood_url
    assert_response :success

    get edit_neighborhood_url(@neighborhood)
    assert_response :success
  end

  test "creates neighborhood" do
    assert_difference("Neighborhood.count", 1) do
      post neighborhoods_url,
           params: { neighborhood: { name: "New District" } }
    end

    assert_redirected_to neighborhoods_url
  end

  test "rejects invalid neighborhood" do
    assert_no_difference("Neighborhood.count") do
      post neighborhoods_url,
           params: { neighborhood: { name: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "updates neighborhood" do
    patch neighborhood_url(@neighborhood),
          params: { neighborhood: { name: "Updated District" } }

    assert_redirected_to neighborhoods_url
    assert_equal "Updated District", @neighborhood.reload.name
  end

  test "deletes neighborhood" do
    assert_difference("Neighborhood.count", -1) do
      delete neighborhood_url(@neighborhood)
    end

    assert_redirected_to neighborhoods_url
  end
end
