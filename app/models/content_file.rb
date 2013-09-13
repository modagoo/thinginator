class ContentFile < ActiveRecord::Base
  has_one :content, :as => :contentable
  has_attached_file :value
end
