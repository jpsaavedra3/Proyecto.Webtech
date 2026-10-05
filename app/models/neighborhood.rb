class Neighborhood < ApplicationRecord
  has_many :properties
  has_many :listings, through: :properties

  validates :name, presence: true, uniqueness: true
end
