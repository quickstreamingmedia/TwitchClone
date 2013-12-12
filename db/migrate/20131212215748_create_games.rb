class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :icon_url
      t.string :wallpaper_url

      t.timestamps
    end
  end
end
