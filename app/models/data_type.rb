class DataType < ActiveRecord::Base
  include Sluggable
  has_many :properties
  validates_presence_of :name
end
