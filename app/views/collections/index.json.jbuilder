json.array!(@collections) do |collection|
  json.extract! collection, :name, :slug
  json.url collection_url(collection, format: :json)
end
