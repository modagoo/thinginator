module ClassificationsHelper

  def fields_for_property(resource, asset, &block)
    prefix = asset.new_record? ? 'new' : 'existing'
    fields_for("#{resource}[#{prefix}_property_attributes][]", asset, &block)
  end

end
