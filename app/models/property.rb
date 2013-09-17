class Property < ActiveRecord::Base
  include Sluggable
  belongs_to :data_type
  belongs_to :collection
  has_many :validations, dependent: :destroy
  has_many :validation_types, through: :validations, dependent: :destroy
  accepts_nested_attributes_for :validations, allow_destroy: true
  validates :name, :data_type, presence: true
  validates :name, uniqueness: { scope: :collection }
  after_save :update_thing_accessors
  before_destroy :destroy_content!
  validate :thing_integrity

  private

  def update_thing_accessors
    Property.all.each do |property|
      Thing.__send__(:attr_accessor, property.slug.to_sym)
    end
  end

  def thing_integrity
    locked_attributes = %w(name data_type_id)
    if (self.changed & locked_attributes).any?
      unless Content.find_by_property_id(id).nil?
        errors.add(:base, "property has data - cannot be edited")
      end
    end
  end

  def destroy_content!
    Content.find_all_by_property_id(id).each do |content|
      content.contentable.try(:destroy)
      content.delete
    end
  end

end
