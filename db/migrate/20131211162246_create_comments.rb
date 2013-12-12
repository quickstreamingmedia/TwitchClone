class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :parent_id
      t.integer :video_id
      t.integer :user_id
      t.string :body

      t.timestamps
    end
    add_index(:comments, :parent_id)
    add_index(:comments, :video_id)
    add_index(:comments, :user_id)
  end
end
