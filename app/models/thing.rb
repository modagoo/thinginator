class Thing < ActiveRecord::Base
  has_many :content, :dependent => :destroy
  belongs_to :collection

  attr_accessor :my_attributes

  after_initialize :build_content_attributes
  after_save :save_collection_attributes

  private

  def build_content_attributes
    if collection.present?
      lg("bulding content_attributes")
      self.my_attributes = []
      self.collection.properties.each do |property|
        self.class.__send__(:attr_accessor, property.slug)
        self.my_attributes << { data_type: property.data_type.name, name: property.slug, property_id: property.id }
      end
    end
  end

  def save_collection_attributes
    logger.info(">>>>>>>>>>>>>>>>>>>" + self.inspect)
    # self.collection.properties.each do |my_attribute|
    #   c = Content.new(thing_id: self.id)
    #   c.property = Property.find(my_attributes[:property_id])
    #   c.contentable = create_new_value(my_attribute[:name], my_attribute[:data_type])
    #   c.save
    # end
  end

  def create_new_value(name, datatype)
    case datatype
    when String
      ret = ContentString.new(value: self.name.to_sym)
    when Fixum
      ret = ContentInteger.new(value: self.name.to_sym)
    else
      nil
    end
  end

  def lg(msg)
    ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    #{msg}

    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  end

end


# def create_new_value(property_type, my_value)
#   my_value = cast_content(my_value)
#   data_type = case property_type.data_type.db_type
#     when "ContentString"
#       ret = ContentString.new(:value => my_value)
#     when "ContentText"
#       ret = ContentText.new(:value => my_value)
#     when "ContentBoolean"
#       ret = ContentBoolean.new(:value => my_value)
#     else
#       nil
#   end
#   ret
# end


# Content.new(:article_id => a.id)
#       property_type = Property.find(content[0])
#       # content_type = property_type.data_type.db_type
#       # Save content value in appropriate table
#       # TODO - work out how to dynamically do this - 10 12 2007 PG
#       property_value = create_new_value(property_type, content[1])
#       # if content_type == "ContentString"
#       #   property_value = ContentString.new(:value => content[1])
#       # elsif content_type == "ContentText"
#       #   property_value = ContentText.new(:value => content[1])
#       # elsif content_type == "ContentInteger"
#       #   property_value = ContentInteger.new(:value => content[1])
#       # elsif content_type == "ContentBoolean"
#       #   property_value = ContentBoolean.new(:value => content[1])
#       # end
#       # Add the polymorphic association
#       content_property.resource = property_value
#       # Save the property id to the contents table
#       content_property.property = property_type
#       # Save it
#       content_property.save
