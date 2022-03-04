class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_signup
  rescue_from Exceptions::InvalidZipcode, with: :invalid_signup

  def create
    build_resource(sign_up_params)

    zone = find_zone(resource, zone_params)
    resource.save!
    resource.create_user_zone!(hardiness_zone: zone)

    render json: resource
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  private

  def invalid_signup(exception)
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  def zone_params
    params.require(:user).permit(:zipcode)
  end

  def find_zone(user, zone_params)
    zipcode = zone_params[:zipcode]
    zone = HardinessZone.find_by(zipcode: zipcode)
    if !zone
      zone = create_hardiness_zone(zipcode)
    end
    zone
  end

  def create_hardiness_zone(zipcode)
    begin
      zone_data = JSON.parse(Rails.cache.redis.get(zipcode))
      zone = HardinessZone.create!(zone_data)
    rescue
      raise Exceptions::InvalidZipcode, 'The zipcode provided is not valid'
    end
  end
end