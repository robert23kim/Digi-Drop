class CreateCollectibles < ActiveRecord::Migration
  def change
    create_table :collectibles do |t|
      t.string :name
      t.string :rarity
      t.string :url
      t.float :value
      # Add fields that let Rails automatically keep track
      # of when collectibles are added or modified:
      t.timestamps
    end
  end
end
