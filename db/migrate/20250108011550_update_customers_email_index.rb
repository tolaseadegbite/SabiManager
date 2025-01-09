class UpdateCustomersEmailIndex < ActiveRecord::Migration[8.0]
  def change
    remove_index :customers, :email
    add_index :customers, [:email, :business_id], unique: true
  end
end
