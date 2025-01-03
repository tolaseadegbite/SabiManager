class AddTaxRateToBusinesses < ActiveRecord::Migration[8.0]
  def change
    add_column :businesses, :tax_rate, :decimal, precision: 5, scale: 2, default: 0.0
  end
end
