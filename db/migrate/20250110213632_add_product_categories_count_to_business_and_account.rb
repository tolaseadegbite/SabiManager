class AddProductCategoriesCountToBusinessAndAccount < ActiveRecord::Migration[8.0]
  def change
    add_column :accounts, :product_categories_count, :integer, default: 0
    add_column :businesses, :product_categories_count, :integer, default: 0
  end
end
