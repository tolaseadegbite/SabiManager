class UpdateProductPriceDefaults < ActiveRecord::Migration[8.0]
  def change
    change_column_default :products, :fixed_price, from: "0.0", to: nil
    change_column_default :products, :min_price, from: "0.0", to: nil
    change_column_default :products, :max_price, from: "0.0", to: nil
  end
end
