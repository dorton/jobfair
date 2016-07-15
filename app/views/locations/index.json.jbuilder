json.array!(@locations) do |location|
  json.extract! location, :id, :city, :admin_ids, :event_ids
  json.url location_url(location, format: :json)
end
