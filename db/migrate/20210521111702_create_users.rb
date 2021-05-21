class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.string :payment_data, null: false

      t.timestamps
    end
  end
end
