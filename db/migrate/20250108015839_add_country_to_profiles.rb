class AddCountryToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :country, :string
  end
end
