class AddTweetIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :tweet_id, :integer
  end
end
