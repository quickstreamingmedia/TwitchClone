class CreateWatchings < ActiveRecord::Migration
  def change
    create_table :watchings do |t|
      t.integer :user_id
      t.integer :page_id

      t.timestamps
    end
    add_index(:watchings, :user_id)
    add_index(:watchings, :page_id)
  end
end
