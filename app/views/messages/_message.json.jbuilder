json.extract! message, :id, :guest_id, :listing_id, :content, :created_at, :updated_at
json.url message_url(message, format: :json)