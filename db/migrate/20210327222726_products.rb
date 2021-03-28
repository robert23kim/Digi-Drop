class Products < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :user_id
      t.integer :asset_id
      t.float :sell_price
      # Add fields that let Rails automatically keep track
      # of when marketplace_items are added or modified:
      t.timestamps
    end
  end
end
