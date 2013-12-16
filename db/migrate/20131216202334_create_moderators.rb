class CreateModerators < ActiveRecord::Migration
  def change
    create_table :moderators do |t|
      t.integer :page_id
      t.integer :user_id

      t.timestamps
    end
    add_index(:moderators, :page_id)
    add_index(:moderators, :user_id)
  end
end
