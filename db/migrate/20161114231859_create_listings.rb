class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.references :host, foreign_key: { to_table: :users }
      t.references :region, foreign_key: true
      t.string :address
      t.decimal :lat, precision: 9, scale: 6
      t.decimal :lng, precision: 9, scale: 6

      t.timestamps
    end
    add_index :listings, :address, unique: true
  end
end
