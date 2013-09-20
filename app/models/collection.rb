require 'active_support/inflector'

class Collection < ActiveRecord::Base

  has_many :things, dependent: :destroy
  has_many :properties, dependent: :destroy
  accepts_nested_attributes_for :properties, allow_destroy: true
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, exclusion: { in: %w(__FILE__ __LINE__ BEGIN END alias and begin break case class def defined? do else elsif end ensure false for if in module next nil not or redo rescue retry return self super then true undef unless until when while yield) }
  before_validation :pluralize_name
  include Sluggable

  def pluralize_name
    self.name = name.pluralize
  end

end
