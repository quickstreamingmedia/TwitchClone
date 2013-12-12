class CreateVideoFavorites < ActiveRecord::Migration
  def change
    create_table :video_favorites do |t|
      t.integer :video_id
      t.integer :user_id

      t.timestamps
    end
    add_index(:video_favorites, :video_id)
    add_index(:video_favorites, :user_id)
  end
end
