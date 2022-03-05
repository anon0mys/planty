class SeedCatalog < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :seed

  scope :name_eq, -> (name) { joins(:seed).where('seeds.name ILIKE ?', "%#{name.downcase}%") }
end
