ActiveAdmin.register Seed do

  permit_params :botanical_name, :height, :spacing, :depth, :spread, :light_required,
                :pollinator, :yield, :color, :size, :blooms, :fruit, :days_to_maturity,
                :zone, :germination, :form, :flower_form, :soil_requirements, :growth_rate,
                :seed_count, :pruning, :foliage, :name, :category, :planting_date
  
  index do
    selectable_column
    id_column
    column :name
    column :category
    column :planting_date
    actions
  end

  filter :name
  filter :category
  filter :planting_date
end
