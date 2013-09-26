class ValidationType < ActiveRecord::Base
  has_many :validations
  belongs_to :user
  has_many :properties, through: :validation
  has_and_belongs_to_many :data_types
  accepts_nested_attributes_for :data_types, allow_destroy: true
end
