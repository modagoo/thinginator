class Collection < ActiveRecord::Base
  include Sluggable
  has_many :things, dependent: :destroy
  has_many :properties, dependent: :destroy
  accepts_nested_attributes_for :properties, allow_destroy: true
  validates_presence_of :name
  validates_uniqueness_of :name
end
