class ContentDatetime < ActiveRecord::Base
  has_one :content, as: :contentable, dependent: :destroy

  def value
    self[:value].to_s(:datetime) if self[:value].present?
  end

end
