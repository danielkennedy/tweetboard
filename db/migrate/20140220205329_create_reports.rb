class CreateReports < ActiveRecord::Migration
  def up
    create_table :reports do |t|
      t.string :positive_tweet_1
      t.string :positive_tweet_2
      t.string :positive_tweet_3
      t.string :negative_tweet_1
      t.string :negative_tweet_2
      t.string :negative_tweet_3
      t.integer :score
      t.timestamps
    end
  end

  def down
    drop_table :reports
  end
end
