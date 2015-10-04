require "instagram"

class InstacallController < ApplicationController

  def brain
    # checks if :code parameter used to authorize Instagram is in URL
    if params[:code]
      link_instagram()
    # Checks if Instagram hub.challenge is present if URL, if so, server responds with hub.challenge to authorize subscription
    elsif params["hub.challenge"]
      render plain: params["hub.challenge"]
    end

  end

  # Links Instagram to Twitter account already registered on InstaEmbed.me
  def link_instagram()
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL) # Gets the access_token via instagram gem
    session[:access_token] = response.access_token # creates session variable of the access_token

    client = Instagram.client(:access_token => session[:access_token]) # Creates an instagram client based on the access_token from above
    person = client.user # Dumps the client's current user into 'person'

    insta_hash = Hash.new # Initualizes new has to pass on when updating User with Instagram

    insta_hash["insta_uid"] = person.id
    insta_hash["insta_handle"] = person.username
    insta_hash["twitter_uid"] = almost_current_user.id

    @user = User.update_with_instagram(insta_hash) # Updates User with info from insta_hash

    if @user.instagram_uid != person.id # Checks to see if the @user has linked their Instagram account in the database
      session[:almost_user_id] = @user.id # If they haven't, it sets their session variable with an 'almost' user ID and redirects them to link their accoun
    else
      session[:user_id] = session[:almost_user_id] # Initializes an actual session
      session[:almost_user_id] = nil # Destroys the 'almost' session
    end

    redirect_to root_path
  end
end
