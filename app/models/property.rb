class Property < ActiveRecord::Base
  include Sluggable
  belongs_to :data_type
  belongs_to :collection
  validates_presence_of :name
  validates_presence_of :data_type
  validates :name, :uniqueness => { scope: :collection }
  after_save :update_thing_accessors

  def update_thing_accessors
    Property.all.each do |property|
      Thing.__send__(:attr_accessor, property.slug.to_sym)
    end
  end

end
