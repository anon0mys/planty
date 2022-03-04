class AddPlantingDateToSeed < ActiveRecord::Migration[6.1]
  def change
    add_column :seeds, :planting_date, :string
  end
end
