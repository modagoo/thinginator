class ValidationType < ActiveRecord::Base
  has_many :validations
  belongs_to :user
  has_many :properties, through: :validation
end
