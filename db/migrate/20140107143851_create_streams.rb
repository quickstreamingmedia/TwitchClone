class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
    add_index(:streams, :user_id)
    add_index(:streams, :game_id)
  end
end
