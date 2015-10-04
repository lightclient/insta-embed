require "net/http"
require "open-uri"

class Post < ActiveRecord::Base
  belongs_to :user

  before_create :post_to_twitter
  validates :user_id, presence: true

  def self.create_post_from_media_id(id)

    # Scrapes media's info from Instagram website
    json_object = Net::HTTP.get_response(URI.parse("https://api.instagram.com/v1/media/" + id + "/?client_id=2954598143aa4dbba123da8a68de1466")).body

    # Converts Instagram response from JSON to a hash
    data = JSON.parse(json_object)

    # Searches for the user whose Instagram ID matches the ID of the Instagram media POSTed to us
    user = User.where(instagram_uid: data["data"]["user"]["id"])


    tweet = data["data"]["caption"]["text"]

    links = tweet.scan(/\b(?:(?:https?|ftp|file):\/\/|www\.|ftp\.)[-A-Z0-9+&@#\/%=~_|$?!:,.]*[A-Z0-9+&@#\/%=~_|$]/i)
    length = 140 - (links.count-1) * 22

    if tweet.chars.length > length
      tweet = tweet[0][tweet.chars.length-3] + "..."
    end

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

  def post_to_twitter
    image = File.new('/tmp/img.png').do |f| f.write(open(media).read) end
    user.twitter.update_with_media(tweet_body, open("http://vignette3.wikia.nocookie.net/fantendo/images/e/eb/Mario_SM3DW.png"))
  end

end
