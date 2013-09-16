class Property < ActiveRecord::Base
  include Sluggable
  belongs_to :data_type
  belongs_to :collection
  has_one :property_validation
  has_one :validation_types, through: :property_validations

  accepts_nested_attributes_for :property_validation, allow_destroy: true

  validates_presence_of :name
  validates_presence_of :data_type
  validates :name, :uniqueness => { scope: :collection }
  after_save :update_thing_accessors

  after_initialize :prep_property_validation

  private

  def prep_property_validation
    if self.property_validation.nil?
      self.build_property_validation
    end
  end

  def update_thing_accessors
    Property.all.each do |property|
      Thing.__send__(:attr_accessor, property.slug.to_sym)
    end
  end

end
