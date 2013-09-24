class ContentList < ActiveRecord::Base
  has_one :content, as: :contentable, dependent: :destroy
  serialize :value
end
