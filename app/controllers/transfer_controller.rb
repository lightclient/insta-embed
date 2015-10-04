class TransferController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index

    if params['_json'][0]['data']['media_id'] # Checks to see if this is a POST request from Instagram

      media_id = params['_json'][0]['data']['media_id']

      Post.create_post_from_media_id(media_id) # If it is, then it passes the media ID of the newly posted media

    end
  end
end
