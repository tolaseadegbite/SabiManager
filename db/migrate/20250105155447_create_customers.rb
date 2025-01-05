class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.decimal :amount_spent
      t.references :business, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end

    add_index :customers, :email,                unique: true
    add_index :customers, :phone_number,         unique: true
  end
end
