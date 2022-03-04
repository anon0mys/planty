class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :zipcode, :zone, :last_frost, :last_frost_short, :token

  def zipcode
    object.hardiness_zone.zipcode
  end

  def zone
    object.hardiness_zone.zone
  end

  def last_frost
    object.hardiness_zone.last_frost
  end

  def last_frost_short
    object.hardiness_zone.last_frost_short
  end

  def token
    object.generate_jwt
  end
end
