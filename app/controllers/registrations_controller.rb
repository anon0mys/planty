class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_signup

  def create
    build_resource(sign_up_params)

    resource.save!
    add_zone(resource, zone_params)

    render json: resource
  end

  private

  def invalid_signup(exception)
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  def zone_params
    params.require(:user).permit(:zipcode)
  end

  def add_zone(user, zone_params)
    zipcode = zone_params[:zipcode]
    zone = HardinessZone.zipcode_eq(zipcode)
    if !zone.exists?
      zone_data = JSON.parse(Rails.cache.redis.get(zipcode))
      zone = HardinessZone.create!(zone_data)
    end
    user.create_user_zone!(hardiness_zone: zone)
  end
end