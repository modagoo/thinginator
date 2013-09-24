class ListValue < ActiveRecord::Base
  belongs_to :list
  validates :value, presence: true, uniqueness: { scope: :list }, exclusion: { in: %w(__FILE__ __LINE__ BEGIN END alias and begin break case class def defined? do else elsif end ensure false for if in module next nil not or redo rescue retry return self super then true undef unless until when while yield) }
end