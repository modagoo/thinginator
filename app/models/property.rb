class Property < ActiveRecord::Base
  include Sluggable
  belongs_to :data_type
  belongs_to :collection
  has_many :property_validations, dependent: :destroy
  has_many :validation_types, through: :property_validations, dependent: :destroy
  accepts_nested_attributes_for :property_validations, allow_destroy: true
  validates_presence_of :name
  validates_presence_of :data_type
  validates :name, :uniqueness => { scope: :collection }
  after_save :update_thing_accessors

  private

  def update_thing_accessors
    Property.all.each do |property|
      Thing.__send__(:attr_accessor, property.slug.to_sym)
    end
  end

end
