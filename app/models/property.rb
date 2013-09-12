class Property < ActiveRecord::Base
  include Sluggable
  belongs_to :data_type
  belongs_to :collection
  validates_presence_of :name
  validates_presence_of :data_type
  validates :name, :uniqueness => { scope: :collection }
end
