class Validation < ActiveRecord::Base
  belongs_to :property
  belongs_to :validation_type
  validates :validation_type_id, presence: true
  validates :value, presence: true, if: "self.validation_type.requires_value?"
  validates :value, absence: true, unless: "self.validation_type.requires_value?"
end
