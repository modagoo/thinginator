json.array!(@classifications) do |classification|
  json.extract! classification, :name, :slug
  json.url classification_url(classification, format: :json)
end
