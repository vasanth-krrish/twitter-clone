class CreateUploadables < ActiveRecord::Migration[6.0]
  def change
    create_table :uploadables do |t|

      t.timestamps
    end
  end
end
