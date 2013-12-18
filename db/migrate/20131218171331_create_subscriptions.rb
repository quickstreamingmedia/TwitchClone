class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :page_id
      t.integer :user_id
      t.integer :number_of_payments

      t.timestamps
    end
  end
end
