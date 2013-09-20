class ContentFile < ActiveRecord::Base
  has_one :content, as: :contentable, dependent: :destroy
  has_attached_file :value, {
    path: "#{Rails.root}/files/:class/:attachment/:id_partition/:style/:filename",
    url: "/file/:id"
  }

end
