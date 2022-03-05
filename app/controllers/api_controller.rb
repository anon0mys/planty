class ApiController < ApplicationController
  include Authenticatable

  respond_to :json
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordInvalid, with: :invalid_post
  rescue_from Exceptions::MissingSearchParam, with: :invalid_params
  rescue_from Exceptions::NotAuthorized, with: :not_authorized

  private

  def invalid_params(exception)
    render json: {errors: exception.message}, status: :bad_request
  end

  def invalid_post(exception)
    render json: {errors: exception.message}, status: :unprocessable_entity
  end

  def not_authorized
    render json: {errors: 'Please log in.'}, status: :unauthorized
  end
end