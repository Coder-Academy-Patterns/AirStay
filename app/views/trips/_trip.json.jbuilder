json.extract! trip, :id, :guest_id, :listing_id, :check_in_date, :check_out_date, :stripe_charge_id, :created_at, :updated_at
json.url trip_url(trip, format: :json)