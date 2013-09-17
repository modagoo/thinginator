require 'active_support/inflector'

class Collection < ActiveRecord::Base

  include Sluggable
  has_many :things, dependent: :destroy
  has_many :properties, dependent: :destroy
  accepts_nested_attributes_for :properties, allow_destroy: true
  validates :name, presence: true
  validates :name, uniqueness: true
  before_validation :pluralize_name

  def pluralize_name
    self.name = name.pluralize
  end

end
