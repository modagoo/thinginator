class Property < ActiveRecord::Base
  include Sluggable
  belongs_to :data_type
  belongs_to :classification
  validates_presence_of :name
end
