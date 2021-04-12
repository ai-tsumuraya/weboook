class CreateKeeps < ActiveRecord::Migration[5.2]
  def change
    create_table :keeps do |t|
      t.references :user, foreign_key: true
      t.references :bookmark, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :bookmark_id], unique: true
    end
  end
end
