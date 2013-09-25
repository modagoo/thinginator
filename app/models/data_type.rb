class DataType < ActiveRecord::Base
  has_many :properties
  belongs_to :user
  validates :friendly_name, :name, presence: true
end
