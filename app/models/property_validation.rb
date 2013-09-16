class PropertyValidation < ActiveRecord::Base
  belongs_to :property
  belongs_to :valdation_type
end
