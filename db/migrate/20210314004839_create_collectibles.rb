class CreateCollectibles < ActiveRecord::Migration
  def change
    create_table :collectibles do |t|
      t.string :name
      t.float :rarity
      t.string :url
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end
