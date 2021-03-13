class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end
