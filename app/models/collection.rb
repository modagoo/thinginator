require 'active_support/inflector'

class Collection < ActiveRecord::Base

  has_many :things, dependent: :destroy
  has_many :properties, dependent: :destroy
  accepts_nested_attributes_for :properties, allow_destroy: true
  validates_presence_of :name
  validates_uniqueness_of :name
  before_validation :pluralize_name
  include Sluggable

  def pluralize_name
    self.name = name.pluralize
  end

end
