class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :payment_data

      t.timestamps
    end
  end
end
