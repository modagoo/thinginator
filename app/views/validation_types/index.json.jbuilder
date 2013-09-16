json.array!(@validation_types) do |validation_type|
  json.extract! validation_type, :name, :slug
  json.url validation_type_url(validation_type, format: :json)
end
