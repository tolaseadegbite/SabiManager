class AddProductsCountAttribute < ActiveRecord::Migration[8.0]
  def change
    add_column :accounts, :products_count, :integer, default: 0
    add_column :businesses, :products_count, :integer, default: 0
    add_column :product_categories, :products_count, :integer, default: 0
  end
end
