class ChangeAvatarShotsUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :avatar_shot, :string, :default => ''
  end
end
