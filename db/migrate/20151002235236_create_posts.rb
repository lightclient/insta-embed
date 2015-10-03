class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

#     t.string :uid
      t.string :ig_body
      t.string :media
      t.string :tweet_body

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :posts, [:user_id, :created_at]
  end
end
