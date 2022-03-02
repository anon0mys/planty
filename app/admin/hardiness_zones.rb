ActiveAdmin.register HardinessZone do
  permit_params :zipcode, :zone, :trange, :zonetitle

  index do
    selectable_column
    id_column
    column :zipcode
    column :zone
    column :trange
    column :zonetitle
    actions
  end
end
