class CreateSeedCatalogs < ActiveRecord::Migration[6.1]
  def change
    create_table :seed_catalogs do |t|
      t.boolean :planted

      t.references :user
      t.references :seed

      t.timestamps
    end
  end
end
