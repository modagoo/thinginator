class Property < ActiveRecord::Base
  has_one :data_type
  belongs_to :record_types
end
