class Assets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :user_id
      t.integer :collectible_id
      t.integer :on_the_market, :default => 0
	  t.float :blurNum
      # Add fields that let Rails automatically keep track
      # of when assets are added or modified
      t.timestamps
    end
  end
end
