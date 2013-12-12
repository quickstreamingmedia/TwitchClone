class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.integer :page_id
      t.text :body
      t.string :image_url
      t.string :image_url_link

      t.timestamps
    end
    add_index(:containers, :page_id)
  end
end
