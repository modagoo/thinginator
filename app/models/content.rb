class Content < ActiveRecord::Base
  belongs_to :contentable, :polymorphic => true
  belongs_to :thing
  belongs_to :property
  before_destroy :delete_contentable

  private

  def delete_contentable
    self.contentable.try(:delete)
  end

end
