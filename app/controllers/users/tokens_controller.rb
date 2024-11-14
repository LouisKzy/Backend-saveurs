class Users::TokensController < ApplicationController
  before_action :authenticate_user!, only: :refresh

  # POST /users/tokens/refresh
  def refresh
    if params[:refresh_token] == current_user.refresh_token
      new_token = Warden::JWTAuth::UserEncoder.new.call(current_user, :user, nil).first
      render json: { token: new_token }, status: :ok
    else
      render json: { error: 'Token invalide' }, status: :unauthorized
    end
  end
end