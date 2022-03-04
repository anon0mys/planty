class CreateSeeds < ActiveRecord::Migration[6.1]
  def change
    create_table :seeds do |t|
      t.string :botanical_name
      t.string :height
      t.string :spacing
      t.string :depth
      t.string :spread
      t.string :light_required
      t.string :pollinator
      t.string :yield
      t.string :color
      t.string :size
      t.string :blooms
      t.string :fruit
      t.string :days_to_maturity
      t.string :zone
      t.string :germination
      t.string :form
      t.string :flower_form
      t.string :soil_requirements
      t.string :growth_rate
      t.string :seed_count
      t.string :pruning
      t.string :foliage
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
