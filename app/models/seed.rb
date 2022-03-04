class Seed < ApplicationRecord
  include Filterable
  
  validates_presence_of :name, :botanical_name, :category

  scope :name_eq, -> (name) { where 'name ILIKE ?', "%#{name.downcase}%" }
end
