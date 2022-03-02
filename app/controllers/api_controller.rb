class ApiController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  rescue_from Exceptions::MissingSearchParam, with: :invalid_params

  def invalid_params(exception)
    render json: {errors: exception.message}, status: :bad_request
  end
end