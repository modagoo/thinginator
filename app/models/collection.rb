require 'active_support/inflector'

class Collection < ActiveRecord::Base

  has_many :things, dependent: :destroy
  has_many :properties, -> { order('sort ASC') }, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :properties, allow_destroy: true
  validates :name, presence: true
  validates :name, uniqueness: true
  validate :must_have_at_least_one_property
  validate :user, presence: true
  before_validation :pluralize_name
  include Sluggable

  def pluralize_name
    self.name = name.pluralize
  end

  private

  def must_have_at_least_one_property
    errors.add :base, "Must have at least one property" unless properties.any?
  end

end
