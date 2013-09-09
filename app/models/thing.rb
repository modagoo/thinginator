class Thing < ActiveRecord::Base
  has_many :content, :dependent => :destroy
  belongs_to :collection

  attr_accessor :my_attributes

  after_initialize :build_content_attributes

  private

  def build_content_attributes
    if collection.present?
      self.my_attributes = []
      self.collection.properties.each do |property|
        self.class.__send__(:attr_accessor, property.slug)
        self.my_attributes << property.slug
      end
    end
  end

end
