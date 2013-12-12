class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :short_bio
      t.text :long_bio
      t.boolean :valid
      t.boolean :is_admin
      t.boolean :show_status
      t.string :status

      t.timestamps
    end
    add_index(:users, :username)
  end
end
