json.array!(@users) do |username|
  json.extract! username, :firstname, :lastname
  json.url username_url(username, format: :json)
end
