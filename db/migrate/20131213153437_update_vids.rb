class UpdateVids < ActiveRecord::Migration
  def change
    add_column(:videos, :cid, :string)
  end
end
