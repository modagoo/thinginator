class Property < ActiveRecord::Base
  include Sluggable
  has_one :data_type
  belongs_to :record_types
  validates_presence_of :name
end
