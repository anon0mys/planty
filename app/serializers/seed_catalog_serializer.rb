class SeedCatalogSerializer < ActiveModel::Serializer
  attributes :id, :planted, :name, :planting_date

  def name
    object.seed.name
  end

  def planting_date
    object.seed.planting_date
  end
end
