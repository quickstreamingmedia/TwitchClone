class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :followee_id
      t.boolean :email_when_live
      t.integer :sort_priority

      t.timestamps
    end
    add_index(:follows, :follower_id)
    add_index(:follows, :followee_id)
  end
end
