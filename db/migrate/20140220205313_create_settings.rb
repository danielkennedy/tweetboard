class CreateSettings < ActiveRecord::Migration
  def up
    create_table :settings do |t|
      t.string :twitter_consumer_key
      t.string :twitter_consumer_secret
      t.string :twitter_access_token
      t.string :twitter_access_token_secret
      t.string :alchemy_api_key
      t.string :twitter_search_string
      t.timestamps
    end
  end

  def down
    drop_table :settings
  end
end
