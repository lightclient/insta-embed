require "instagram"

class InstacallController < ApplicationController

  def brain
    if params[:code]
      link_instagram(:code)
    end

    if params[:hub_challenge]
      render params[:hub_challenge]
    end
  end

  def link_instagram(code)
    response = Instagram.get_access_token(params[code, :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token

    client = Instagram.client(:access_token => session[:access_token])
    person = client.user

    insta_hash = Hash.new

    insta_hash["insta_uid"] = person.id
    insta_hash["insta_handle"] = person.username
    insta_hash["twitter_uid"] = almost_current_user.id

    User.update_with_instagram(insta_hash)

    session[:user_id] = session[:almost_user_id]
    session[:almost_user_id] = nil

    redirect_to root_path
  end

end
