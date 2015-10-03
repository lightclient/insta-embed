class TransferController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    
    if params["_json"][0]["data"]["media_id"]

      media_id = params["_json"][0]["data"]["media_id"]

      Post.create_post_from_media_id(media_id)

    end
  end
end
