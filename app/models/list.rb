class List < ActiveRecord::Base
  include Sluggable
  belongs_to :user
  has_many :list_values, dependent: :destroy, order: 'sort asc'

  has_many :data_lists
  has_many :properties, through: :data_lists

  validates :name, presence: true, exclusion: { in: %w(__FILE__ __LINE__ BEGIN END alias and begin break case class def defined? do else elsif end ensure false for if in module next nil not or redo rescue retry return self super then true undef unless until when while yield) }
  validates :user, presence: true
  accepts_nested_attributes_for :list_values, allow_destroy: true
end
