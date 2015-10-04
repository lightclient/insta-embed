class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash) # Creates a user in the database based on info in the auth_hash

    if @user.instagram_uid == nil # Checks to see if the @user has linked their Instagram account in the database
      session[:almost_user_id] = @user.id # If they haven't, it sets their session variable with an 'almost' user ID and redirects them to link their account
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
