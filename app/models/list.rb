class List < ActiveRecord::Base
  include Sluggable
  belongs_to :user
  has_many :list_values, -> { order('sort ASC') }, dependent: :destroy
  has_many :data_lists
  has_many :properties, through: :data_lists
  validates :user, presence: true
  accepts_nested_attributes_for :list_values, allow_destroy: true
end
