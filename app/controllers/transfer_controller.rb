class TransferController < ApplicationController
  def index
    puts params["data"]
    #puts params["_json"]["data"]["media_id"]
    #puts params
  end
end
