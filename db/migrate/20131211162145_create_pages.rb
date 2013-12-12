class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :user_id
      t.string :logo_url
      t.string :stream_title
      t.string :background_url
      t.string :banner_url

      t.timestamps
    end
  end
end
