class Classification < ActiveRecord::Base
  include Sluggable
  has_many :properties
  accepts_nested_attributes_for :properties, allow_destroy: true
end
