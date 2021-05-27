class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.string :status, null: false

      t.timestamps
    end
    add_index :orders, :user_id
  end
end
