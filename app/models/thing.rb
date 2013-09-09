class Thing < ActiveRecord::Base
  has_many :content, :dependent => :destroy
  belongs_to :collection

  attr_accessor :my_attributes

  after_initialize :build_attributes_from_properties#, :build_content_attributes

  private

  # def build_content_attributes
  #   if self.collection.present?
  #     self.collection.properties.each do |property|

  #     end
  #   end
  # end

  def build_attributes_from_properties
    self.my_attributes = []
    Property.all.each do |property|
      self.class.__send__(:attr_accessor, property.slug)
      self.my_attributes << property.slug
    end
  end

end
