class HardinessZone < ApplicationRecord
  validates_presence_of :zipcode, :zone, :trange, :zonetitle
end
