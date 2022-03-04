class ApiController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordInvalid, with: :invalid_post
  rescue_from Exceptions::MissingSearchParam, with: :invalid_params

  private

  def authenticate_user!
    token = request.headers['HTTP_AUTHORIZATION']&.split(' ')&.last
    begin
      jwt_payload = JWT.decode(token, Rails.application.credentials.secret_key_base).first
      @current_user_id = jwt_payload['id']
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      render json: {errors: 'Please log in.'}, status: :unauthorized
    end
  end

  def current_user
    @current_user ||= super || User.find_by(id: @current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end

  def invalid_params(exception)
    render json: {errors: exception.message}, status: :bad_request
  end

  def invalid_post(exception)
    render json: {errors: exception.message}, status: :unprocessable_entity
  end
end