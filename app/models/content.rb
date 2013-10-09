class Content < ActiveRecord::Base
  belongs_to :contentable, :polymorphic => true
  belongs_to :thing
  belongs_to :property
  validates :contentable, presence: true
end
