class RegistrationsController < Devise::RegistrationsController
  include Authenticatable

  clear_respond_to
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_signup
  rescue_from Exceptions::InvalidZipcode, with: :invalid_signup
  rescue_from Exceptions::NotAuthorized, with: :not_authorized

  def create
    build_resource(sign_up_params)

    zone = find_zone(zone_params)
    resource.save!
    resource.create_user_zone!(hardiness_zone: zone)

    render json: resource
  end

  def update
    zone = find_zone(zone_params)
    update_resource(resource, account_update_params)

    resource.replace_zone!(hardiness_zone: zone)
    render json: resource
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def invalid_signup(exception)
    puts exception
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  def not_authorized
    render json: {errors: 'Please log in.'}, status: :unauthorized
  end

  def zone_params
    params.require(:user).permit(:zipcode)
  end

  def find_zone(zone_params)
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