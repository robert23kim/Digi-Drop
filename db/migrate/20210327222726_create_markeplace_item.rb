class CreateMarkeplaceItem < ActiveRecord::Migration
  def change
    create_table :markeplace_items do |t|
      t.integer :user_id
      t.integer :collectible_id
      t.float :sell_price
      # Add fields that let Rails automatically keep track
      # of when marketplace_items are added or modified:
      t.timestamps
    end
  end
end
