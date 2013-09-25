class ContentDate < ActiveRecord::Base
  has_one :content, as: :contentable, dependent: :destroy

  def value
    self[:value].to_s(:date) if self[:value].present?
  end

end
