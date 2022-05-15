class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :trade_name
      t.string :corporate_name
      t.integer :nif
      t.string :address
      t.string :email
      t.integer :phone_number

      t.timestamps
    end
  end
end
