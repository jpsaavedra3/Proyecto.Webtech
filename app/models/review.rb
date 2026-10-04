class Review < ApplicationRecord
  belongs_to :visit
  belongs_to :property
  belongs_to :user
end