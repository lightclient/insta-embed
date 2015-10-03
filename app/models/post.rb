require "net/http"

class Post < ActiveRecord::Base
  belongs_to :user
  #validates :user_id, presence: true

  def self.create_post_from_media_id()

    data = Net::HTTP.get_response(URI.parse("https://api.instagram.com/v1/media/" + params["_json"][0]["data"]["media_id"] + "client_id=2954598143aa4dbba123da8a68de1466")).body

    user = User.where(instagram_uid: data["json"][0]["data"]["user"]["id"])
    user.post.create(
      ig_body: data["json"][0]["data"]["caption"]["text"],
      media: data["json"][0]["data"]["images"]["standard_resolution"]["url"],
      tweet_body: data["json"][0]["data"]["caption"]["text"],
    )
    user
  end

end
