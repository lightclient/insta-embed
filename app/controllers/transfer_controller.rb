class TransferController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  
  def index
    render plain: "HELLO THERE FRIENDS"
    #puts params["data"]
    #puts params["_json"]["data"]["media_id"]
    #puts params
  end
end
