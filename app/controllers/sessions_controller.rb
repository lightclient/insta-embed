class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    if @user.instagram_uid == nil
      session[:almost_user_id] = @user.id
      redirect_to root_path
    else
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
