class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null:false
      t.text :description
      t.boolean :negotiable, default: false
      t.integer :stock_quantity, default: 0
      t.decimal :fixed_price, precision: 5, scale: 2, default: 0.0
      t.decimal :min_price, precision: 5, scale: 2, default: 0.0
      t.decimal :max_price, precision: 5, scale: 2, default: 0.0
      t.references :business, null: false, foreign_key: true
      t.references :product_category, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
