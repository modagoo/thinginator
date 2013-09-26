class DataType < ActiveRecord::Base
  has_many :properties
  belongs_to :user
  has_and_belongs_to_many :validation_types
  validates :friendly_name, :name, presence: true
end
