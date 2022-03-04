class SeedSerializer < ActiveModel::Serializer
  attributes :id, :botanical_name, :height, :spacing, :depth, :spread,
             :light_required, :pollinator, :yield, :color, :size, :blooms,
             :fruit, :days_to_maturity, :zone, :germination, :form, :flower_form,
             :soil_requirements, :growth_rate, :seed_count, :pruning, :foliage,
             :name, :category
end
