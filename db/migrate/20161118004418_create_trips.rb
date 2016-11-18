class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.references :guest, foreign_key: { to_table: :users }
      t.references :listing, foreign_key: true
      t.date :check_in_date, null: false
      t.date :check_out_date, null: false
      t.string :stripe_charge_id

      t.timestamps
    end
    add_index :trips, [:guest, :listing, :check_in_date]
  end
end
