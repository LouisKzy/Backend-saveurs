class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super do |resource|
      if resource.persisted?
        resource.update(refresh_token: SecureRandom.hex(64))
      end
    end
  end

  def destroy
    if current_user
      current_user.update(refresh_token: nil)
      log_out_success
    else
      log_out_failure
    end
  end

  private

  def respond_with(_resource, _opts = {})
    token = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil).first
    render json: {
      message: 'Vous êtes connecté.',
      user: current_user,
      token: token, 
      refresh_token: resource.refresh_token
    }, status: :ok
  end

  def respond_to_on_destroy
    log_out_failure  && return if current_user
    
    log_out_success
  end
  def log_out_success
    request.cookie_jar.delete(:_interslice_session)
    render json: { message: 'Vous êtes bien déconnecté.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Nous rencontrons des problèmes.' }, status: :unauthorized
  end
end