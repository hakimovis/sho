class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.integer :count
      t.integer :item_id
      t.integer :order_id

      t.timestamps
    end
    add_index :line_items, :item_id
    add_index :line_items, :order_id
  end
end
