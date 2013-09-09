class Thing < ActiveRecord::Base
  has_many :content, :dependent => :destroy
  belongs_to :collection
end
