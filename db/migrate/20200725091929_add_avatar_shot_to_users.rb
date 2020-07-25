class AddAvatarShotToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar_shot, :string
  end
end
