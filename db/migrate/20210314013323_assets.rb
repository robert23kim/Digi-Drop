class Assets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :user_id
      t.integer :collectible_id
      # Add fields that let Rails automatically keep track
      # of when assets are added or modified:
      t.timestamps
    end
  end
end
