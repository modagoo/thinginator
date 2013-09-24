class DataList < ActiveRecord::Base
  validates :list_id, presence: true
  belongs_to :property
  belongs_to :list
end
