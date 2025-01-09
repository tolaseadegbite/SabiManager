class UpdateCustomersPhoneNumberIndex < ActiveRecord::Migration[8.0]
  def change
    remove_index :customers, :phone_number
    add_index :customers, [:phone_number, :business_id], unique: true
  end
end
