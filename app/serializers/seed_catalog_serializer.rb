class SeedCatalogSerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    object.seed.name
  end
end
