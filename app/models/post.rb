require "net/http"

class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true

  def self.create_post_from_media_id(id)

    # Scrapes media's info from Instagram website
    json_object = Net::HTTP.get_response(URI.parse("https://api.instagram.com/v1/media/" + id + "/?client_id=2954598143aa4dbba123da8a68de1466")).body

    # Converts Instagram response from JSON to a hash
    data = JSON.parse(json_object)

    # Searches for the user whose Instagram ID matches the ID of the Instagram media POSTed to us
    user = User.where(instagram_uid: data["data"]["user"]["id"])

    # Creates an entry into the database with the info
    Post.create(
      ig_body: data["data"]["caption"]["text"],
      media: data["data"]["images"]["standard_resolution"]["url"],
      tweet_body: data["data"]["caption"]["text"],
      user_id: user[0].id
    )
    # Returns the user
    user
  end

end
