class AddCustomersCountToBusiness < ActiveRecord::Migration[8.0]
  def change
    add_column :accounts, :customers_count, :integer, default: 0
    add_column :businesses, :customers_count, :integer, default: 0
  end
end
