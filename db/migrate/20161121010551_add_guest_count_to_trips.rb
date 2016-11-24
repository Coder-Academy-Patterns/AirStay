class AddGuestCountToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :guest_count, :integer, default: 1
    Trip.update_all(guest_count: 1)
    change_column :trips, :guest_count, :integer, null: false, default: 1
  end
end
