class Application < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  has_many :visits
end