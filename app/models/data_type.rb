class DataType < ActiveRecord::Base
  has_many :properties
  validates :friendly_name, :name, presence: true
end
