module Authenticatable
  def authenticate_user!(force=false)
    token = request.headers['HTTP_AUTHORIZATION']&.split(' ')&.last
    begin
      jwt_payload = JWT.decode(token, Rails.application.credentials.secret_key_base).first
      @current_user_id = jwt_payload['id']
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      raise Exceptions::NotAuthorized, 'Please log in'
    end
  end

  def current_user
    @current_user ||= super || User.find_by(id: @current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end
end