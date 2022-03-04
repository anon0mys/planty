class AddLastFrostToHardinessZone < ActiveRecord::Migration[6.1]
  def change
    add_column :hardiness_zones, :last_frost, :string
    add_column :hardiness_zones, :last_frost_short, :string
  end
end
