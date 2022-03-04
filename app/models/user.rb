class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_zone
  has_one :hardiness_zone, through: :user_zone
  has_many :seed_catalogs
  has_many :seeds, through: :seed_catalogs

  def generate_jwt
    JWT.encode(
      {id: id, exp: 30.days.from_now.to_i},
      Rails.application.secrets.secret_key_base
    )
  end
end
