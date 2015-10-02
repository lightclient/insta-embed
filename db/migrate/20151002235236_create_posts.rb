class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

      t.string :uid
      t.string :ig_body
      t.string :media
      t.string :tweet_body

      t.timestamps null: false
    end
  end
end
