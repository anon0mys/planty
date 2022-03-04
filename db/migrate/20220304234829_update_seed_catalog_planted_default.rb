class UpdateSeedCatalogPlantedDefault < ActiveRecord::Migration[6.1]
  def change
    change_column :seed_catalogs, :planted, :boolean, default: false
  end
end
