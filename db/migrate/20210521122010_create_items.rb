class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.decimal :price, null: false
      t.integer :stock_count, null: false

      t.timestamps
    end
  end
end
