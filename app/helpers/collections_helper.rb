module CollectionsHelper

  def check_for_data(collection, property)
    p = collection.properties.find_by_slug(property.slug)
    if p.nil?
      return {}
    else
      c = Content.find_by_property_id(p.id)
      if c.nil?
        return {}
      else
        return { disabled: "disabled" }
      end
    end
  end

end
