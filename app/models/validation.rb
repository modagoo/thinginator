class Validation < ActiveRecord::Base
  belongs_to :property
  belongs_to :validation_type
  validates :validation_type_id, presence: true
  validate :value_present

  private

  def value_present
    if self.validation_type_id.present?
      if self.validation_type.requires_value? && self.value.blank?
        errors.add :value, "can't be blank"
      end
      if !self.validation_type.requires_value? && self.value.present?
        errors.add :value, "must be blank"
      end
    end
  end

end
