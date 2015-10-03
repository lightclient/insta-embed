class TransferController < ApplicationController
  def index
    render plain: "HELLO THERE FRIENDS"
    #puts params["data"]
    #puts params["_json"]["data"]["media_id"]
    #puts params
  end
end
