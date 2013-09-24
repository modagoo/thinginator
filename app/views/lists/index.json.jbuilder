json.array!(@lists) do |list|
  json.extract! list, :name, :slug
  json.url list_url(list, format: :json)
end
