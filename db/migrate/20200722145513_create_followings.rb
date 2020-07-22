class CreateFollowings < ActiveRecord::Migration[6.0]
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :following

      t.timestamps
    end
  end
end
