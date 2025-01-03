class CreateBusinesses < ActiveRecord::Migration[8.0]
  def change
    create_table :businesses do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :currency, default: 'Naira'

      t.timestamps
    end
  end
end
