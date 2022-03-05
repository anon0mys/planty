class SessionsController < Devise::SessionsController
  clear_respond_to
  respond_to :json
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by_email(sign_in_params[:email])
    if user
      puts "#{user.name} is logging in and their password is valid: #{user.valid_password?(sign_in_params[:password])}"
    end

    if user && user.valid_password?(sign_in_params[:password])
      @current_user = user
      render json: @current_user
    else
      render json: { errors: 'email or password is invalid' }, status: :unprocessable_entity
    end
  end
end