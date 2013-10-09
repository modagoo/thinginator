class Setting < ActiveRecord::Base
  include Sluggable
  validates :name, presence: true
  validates :value, presence: true
end
