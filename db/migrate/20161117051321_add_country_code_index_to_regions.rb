class AddCountryCodeIndexToRegions < ActiveRecord::Migration[5.0]
  def change
    add_index :regions, :country_code
  end
end
