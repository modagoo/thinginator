module ApplicationHelper

  def errors_for(object)
    ret = ""
    if object.errors.any?
      ret += "<div id=\"error_explanation\">"
      ret += "<h2>#{pluralize(object.errors.count, 'error')} prohibited this record from being saved:</h2>"
      ret +=  "<ul>"
      object.errors.full_messages.each do |msg|
        ret += "<li>#{msg}</li>"
      end
      ret += "</ul>"
      ret += "</div>"
      ret.html_safe
    end
  end

  def dev
    return true if Rails.env == "development"
    return false
  end

  # Returns HTML button element
  def btn(text="Submit",type="submit",id="",css_class="btn",icon="")
    ret =  "<button type=\"#{type}\" class=\"#{css_class}\""
    ret +=  " id=\"#{id}\"" unless id.blank?
    ret += ">#{text}"
    ret += " <i class=\"#{icon}\"></i>" if icon.present?
    ret += "</button>"
    ret.html_safe
  end

  def link_to_add_fields(name, f, association, css="")
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields #{css}", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_remove_fields(label, f, css="")
    ret = ""
    ret += f.hidden_field :_destroy , class: 'remove_fields'
    ret += link_to(label, '#', class: "remove_fields #{css}")
    ret.html_safe
  end

end
