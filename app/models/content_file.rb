class ContentFile < ActiveRecord::Base
  has_one :content, as: :contentable, dependent: :destroy
  has_attached_file :value, {
    path: "#{Rails.root}/files/:class/:attachment/:id_partition/:style/:filename",
    url: "/file/:id"
  }
  after_save :set_permissions

  private

  def set_permissions
    File.chmod 0400, self.value.path if self.value.path.present?
  end

end
