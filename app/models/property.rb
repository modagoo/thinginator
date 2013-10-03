class Property < ActiveRecord::Base
  include Sluggable
  belongs_to :data_type
  belongs_to :collection
  has_many :validations, dependent: :destroy
  has_many :validation_types, through: :validations, dependent: :destroy

  has_many :data_lists
  has_many :lists, through: :data_lists


  accepts_nested_attributes_for :validations, allow_destroy: true
  accepts_nested_attributes_for :data_lists, allow_destroy: true
  validates :name, presence: true, uniqueness: { scope: :collection }
  validates :data_type, presence: true
  after_save :update_thing_accessors
  before_destroy :destroy_content!
  after_destroy :update_thing_search_index
  validate :thing_integrity
  validate :suitable_for_datatype

  scope :visible, -> { where('hide IS NOT true') }

  private

  def suitable_for_datatype
    self.validations.each do |v|
      unless self.data_type.validation_types.pluck(:id).include?(v.validation_type.id)
        errors.add :base, "validation is not suitable for this data type"
      end
    end
  end

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
    Content.where(property_id: id).each do |content|
      content.contentable.try(:destroy)
      content.delete
    end
  end

  # TODO - this could get slow! PG 02-10-13
  def update_thing_search_index
    Thing.all.each do |t|
      t.update_index
    end
  end

end
