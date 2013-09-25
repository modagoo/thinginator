class ContentTime < ActiveRecord::Base
  has_one :content, as: :contentable, dependent: :destroy
  validate :value_parses_at_time

  def value
    self[:value].to_s(:time) if self[:value].present?
  end

  private

  def value_parses_at_time
    begin
      Time.parse(value)
    rescue
      errors.add :base, "is not a valid time"
    end
  end

end
