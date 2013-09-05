class DataType < ActiveRecord::Base
  include Sluggable
  belongs_to :property
  validates_presence_of :name
end
