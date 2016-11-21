class CreateListingProvisions < ActiveRecord::Migration[5.0]
  def change
    create_table :listing_provisions do |t|
      t.references :listing, foreign_key: true, null: false
      t.date :start_date, null: false
      t.integer :guests_max, default: 1, null: false
      t.integer :bedroom_count, default: 1, null: false
      t.integer :bed_count, default: 1, null: false
      t.integer :nights_min, default: 1, null: false
      t.integer :nightly_fee_cents, null: false
      t.integer :cleaning_fee_cents, null: false

      t.timestamps
    end
    add_index :listing_provisions, [:listing_id, :start_date], unique: true
  end
end
