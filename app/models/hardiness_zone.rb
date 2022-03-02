class HardinessZone < ApplicationRecord
  include Filterable

  validates_presence_of :zipcode, :zone, :trange, :zonetitle

  scope :zipcode_eq, -> (zipcode) { find_by zipcode: zipcode }
end
