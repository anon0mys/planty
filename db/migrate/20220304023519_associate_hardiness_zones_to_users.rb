class AssociateHardinessZonesToUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_zones do |t|
      t.references :user
      t.references :hardiness_zone
    end
  end
end
