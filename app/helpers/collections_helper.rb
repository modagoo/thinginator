module CollectionsHelper

  def has_no_data?(collection, property)
    p = collection.properties.find_by_slug(property.slug)
    if p.nil?
      return true
    else
      c = Content.find_by_property_id(p.id)
      if c.nil?
        return true
      else
        return false
      end
    end
  end

  def is_disabled?(bool)
    if bool == false
      { disabled: "disabled" }
    else
      {}
    end
  end

end
