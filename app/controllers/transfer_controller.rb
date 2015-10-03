class TransferController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    render plain: "HELLO THERE FRIENDS"
    if params[0]["_json"]["data"]["media_id"]

      Post.create_post_from_media_id(params[0]["_json"]["data"]["media_id"])

    end
  end
end
