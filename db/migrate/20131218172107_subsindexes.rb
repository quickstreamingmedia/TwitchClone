class Subsindexes < ActiveRecord::Migration
  def change
    add_index(:subscriptions, :page_id)
    add_index(:subscriptions, :user_id)
  end
end
