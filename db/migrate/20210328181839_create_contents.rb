class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :case_id
      t.integer :collectible_id
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end
