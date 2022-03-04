class UserZone < ApplicationRecord
  belongs_to :user
  belongs_to :hardiness_zone
end