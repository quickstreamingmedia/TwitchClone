class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :user_id
      t.string :thumbnail_url
      t.string :title
      t.text :description
      t.string :video_url
      t.string :game_title

      t.timestamps
    end

    add_index(:videos, :user_id)
  end
end
