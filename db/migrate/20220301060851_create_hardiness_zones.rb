class CreateHardinessZones < ActiveRecord::Migration[6.1]
  def change
    create_table :hardiness_zones do |t|
      t.string :zipcode
      t.string :zone
      t.string :trange
      t.string :zonetitle

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
