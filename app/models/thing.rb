class Thing < ActiveRecord::Base
  has_many :content
  belongs_to :collection

  # TODO add after_save to Property to rebuild this!
  attr_accessor :my_attributes, *Property.pluck(:slug).collect{|p| p.to_sym}

  after_initialize :build_content_attributes
  after_create :save_collection_attributes
  after_update :update_collection_attributes

  before_destroy :delete_content_and_contentable

  def thing_attributes
    self.collection.properties.pluck(:slug)
  end

  private

  def build_content_attributes
    if collection.present?
      self.my_attributes = []
      self.collection.properties.each do |property|
        # self.class.__send__(:attr_accessor, property.slug.to_sym)
        self.send("#{property.slug}=", get_value(property))
      end
    end
  end

  def save_collection_attributes
    self.collection.properties.each do |p|
      c = Content.new(thing_id: self.id)
      c.property = self.collection.properties.find_by_slug(p.slug)
      c.contentable = create_new_value(self.send(p.slug.to_sym), p.data_type.name)
      c.save
    end
  end

  def update_collection_attributes
    self.collection.properties.each do |p|
      self.content.find_by_property_id(p.id).contentable.update_attribute(:value, self.send(p.slug.to_sym))
    end
  end

  def get_value(property)
    existing_value = self.send(property.slug.to_sym)
    if existing_value.nil?
      return self.content.where(property: property).take(1).first.try(:contentable).try(:value)
    else
      return existing_value
    end
  end

  def create_new_value(value, datatype)
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
    when "File"
      ret = ContentFile.new(value: value)
    else
      nil
    end
  end

  private

  def delete_content_and_contentable
    self.content.each do |content|
      content.contentable.try(:destroy)
      content.delete
    end
  end

end
