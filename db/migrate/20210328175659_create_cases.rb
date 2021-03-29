class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :name
      t.string :url
      t.float :value
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end
