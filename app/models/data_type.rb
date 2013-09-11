class DataType < ActiveRecord::Base
  has_many :properties
  validates_presence_of :friendly_name, :name
end
