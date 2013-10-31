class ContentPrompted < ActiveRecord::Base
  has_one :content, as: :contentable, dependent: :destroy
end
