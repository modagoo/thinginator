json.array!(@settings) do |setting|
  json.extract! validation_type, :name, :slug
  json.url setting_url(setting, format: :json)
end
