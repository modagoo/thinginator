class Property < ActiveRecord::Base
  include Sluggable
  has_one :data_type
  belongs_to :classification
  validates_presence_of :name
end
