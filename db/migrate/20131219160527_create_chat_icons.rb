class CreateChatIcons < ActiveRecord::Migration
  def change
    create_table :chat_icons do |t|
      t.integer :page_id
      t.string :match
      t.string :img_url
      t.boolean :page_specific

      t.timestamps
    end
    add_index(:chat_icons, :page_id)
    add_index(:chat_icons, :page_specific)
  end
end
