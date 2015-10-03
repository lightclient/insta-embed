class TransferController < ApplicationController
  def index
    puts params["_json"]["object_id"]
    puts params["_json"]["data"]["media_id"]
    #puts params
  end
end
