class RemCol < ActiveRecord::Migration
  def change
    remove_column(:users, :valid)
    add_column(:users, :active, :boolean)
  end
end
