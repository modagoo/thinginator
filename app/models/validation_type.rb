class ValidationType < ActiveRecord::Base
  has_many :property_validations
  has_many :properties, through: :property_validation
end
