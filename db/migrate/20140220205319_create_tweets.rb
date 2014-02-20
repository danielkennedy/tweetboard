class CreateTweets < ActiveRecord::Migration
  def up
    create_table :tweets do |t|
      t.string :text
      t.string :user
      t.string :handle
      t.integer :follower_count
      t.integer :retweet_count
      t.integer :favorite_count
      t.timestamps
    end
  end

  def down
    drop_table :tweets
  end
end
