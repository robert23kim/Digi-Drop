class Assets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :user_id
      t.string :collectible_id
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end
