class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.float :balance, :default => 0.0
      # Add fields that let Rails automatically keep track
      # of when users are added or modified:
      t.timestamps
    end
  end
end
