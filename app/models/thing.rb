class Thing < ActiveRecord::Base
  has_many :content, :dependent => :destroy
  belongs_to :collection

  attr_accessor :my_attributes

  after_initialize :build_content_attributes
  after_create :save_collection_attributes

  private

  def build_content_attributes
    if collection.present?
      self.my_attributes = []
      self.collection.properties.each do |property|
        self.class.__send__(:attr_accessor, property.slug)
        self.my_attributes << { data_type: property.data_type.name, name: property.slug, property_id: property.id }
      end
    end
  end

  def save_collection_attributes
    self.collection.properties.each do |my_attribute|
      c = Content.new(thing_id: self.id)
      c.property = self.collection.properties.find_by_slug(my_attribute.slug)
      c.contentable = create_new_value(self.send(my_attribute.slug.to_sym), my_attribute.data_type.name)
      c.save
    end
  end

  def create_new_value(value, datatype)
    return if value.blank?
    case datatype
    when "String"
      ret = ContentString.new(value: value)
    when "Fixnum"
      ret = ContentInteger.new(value: value)
    when "Text"
      ret = ContentText.new(value: value)
    when "Datetime"
      ret = ContentDatetime.new(value: value)
    when "Boolean"
      ret = ContentBoolean.new(value: value)
    else
      nil
    end
  end

end
