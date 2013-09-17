class Thing < ActiveRecord::Base
  attr_accessor :my_attributes, *Property.pluck(:slug).collect{|p| p.to_sym}
  has_many :content
  belongs_to :collection
  after_initialize :build_content_attributes
  after_create :save_collection_attributes
  after_update :update_collection_attributes
  before_destroy :delete_content_and_contentable
  validate :thing_validations

  def thing_attributes
    self.collection.properties.pluck(:slug)
  end

  private

  def build_content_attributes
    if collection.present?
      self.my_attributes = []
      self.collection.properties.each do |property|
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
    if DataType.find_by_name(datatype).nil?
      return nil
    else
      "Content#{datatype}".constantize.new(value: value)
    end
  end

  def delete_content_and_contentable
    self.content.each do |content|
      content.contentable.try(:destroy)
      content.delete
    end
  end

  def thing_validations
    self.collection.properties.each do |property|
      property.validations.each do |validation|
        run_validation(validation, property, self.collection)
      end
    end
  end

  def run_validation(validation, property, collection)
    case validation.validation_type.name
    when "presence"
      if get_value(property).blank?
        errors.add(property.slug.to_sym, "can't be blank")
      end
    when "uniqueness"
      # TODO - this is going to get very slow, very quickly!
      # need a way to search for a thing with specific value, maybe other way round, i.e.
      # make array of possible matches from content,
      # then filter to this thing/collection PG 20130917
      unique = true
      collection.things.each do |t|
        if t.try(property.slug.to_sym) == get_value(property)
          unique = false
        end
        break if unique == false
      end
      if unique == false
        errors.add(property.slug.to_sym, "has been used already")
      end
    when 'acceptance'
      unless get_value(property) == "true" # value not saved yet, hence String
        errors.add(property.slug.to_sym, "must be accepted")
      end
    when 'exclusion'
      if validation.value.present?
        if validation.value.split(',').is_a?(Array)
          validation_list = validation.value.split(',').collect!{|a| a.strip!}
          if validation_list.include?(get_value(property))
            errors.add(property.slug.to_sym, "is reserved")
          end
        end
      end
    when 'inclusion'
      if validation.value.present?
        if validation.value.split(',').is_a?(Array)
          validation_list = validation.value.split(',').collect!{|a| a.strip!}
          unless validation_list.include?(get_value(property))
            errors.add(property.slug.to_sym, "is not included in the list")
          end
        end
      end
    when 'format_with'
      if validation.value.present?
        regexp = Regexp.new validation.value
        if get_value(property).to_s !~ regexp
          errors.add(property.slug.to_sym, "is not formatted correctly")
        end
      end
    when 'format_without'
      if validation.value.present?
        regexp = Regexp.new validation.value
        if get_value(property).to_s =~ regexp
          errors.add(property.slug.to_sym, "is not formatted correctly")
        end
      end
    when "numericality"
      if get_value(property).to_s =~ /\A[+-]?\d+\Z/
        unless get_value(property).to_f.is_a?(Numeric)
          errors.add(property.slug.to_sym, "is not a number")
        end
      else
          errors.add(property.slug.to_sym, "is not a number")
      end
    end
  end

end
