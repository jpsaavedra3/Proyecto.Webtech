
require "test_helper"

class NeighborhoodTest < ActiveSupport::TestCase
  test "requires a name" do
    neighborhood = Neighborhood.new(name: "")

    assert_not neighborhood.valid?
    assert neighborhood.errors[:name].any?
  end

  test "name must be unique" do
    Neighborhood.create!(name: "Test Neighborhood")

    duplicate = Neighborhood.new(name: "Test Neighborhood")

    assert_not duplicate.valid?
    assert duplicate.errors[:name].any?
  end

  test "cannot delete neighborhood with properties" do
    association = Neighborhood.reflect_on_association(:properties)

    assert_equal :restrict_with_error,
                 association.options[:dependent]
  end
end
