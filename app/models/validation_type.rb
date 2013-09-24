class ValidationType < ActiveRecord::Base
  has_many :validations
  has_many :properties, through: :validation
end
