require "net/http"

class Post < ActiveRecord::Base
  belongs_to :user
  #validates :user_id, presence: true

  def self.create_post_from_media_id(id)

    data = Net::HTTP.get_response(URI.parse("https://api.instagram.com/v1/media/" + id + "/?client_id=2954598143aa4dbba123da8a68de1466")).body

    puts data
    puts "--------------------------------------------"
    puts data["data"]["user"]["id"]

    user = User.where(instagram_uid: data["data"]["user"]["id"])
    user.post.create(
      ig_body: data["data"]["caption"]["text"],
      media: data["data"]["images"]["standard_resolution"]["url"],
      tweet_body: data["data"]["caption"]["text"]
    )
    user
  end

end
