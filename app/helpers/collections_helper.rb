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

  def is_disabled?(bool, css=nil, data=nil)
    ret = {}
    if bool == false
      ret.merge!({ disabled: "disabled" })
    end
    if css.present?
      ret.merge!({ class: css })
    end
    if data.present?
      ret.merge!({ data: data})
    end
    ret
  end

end
