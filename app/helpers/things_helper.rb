module ThingsHelper

  def render_form_fields(f, attrs)
    ret = ""
    attrs.each do |a|
      ret << render_field(f, a[:name], a[:data_type])
    end
    ret.html_safe
  end

  def render_field(f, name, data_type)
    case data_type
    when "Fixnum"
      render_text_field(f, name)
    when "String"
      render_text_field(f, name)
    when "Text"
      render_text_area(f, name)
    when "Boolean"
      render_boolean(f, name)
    when "Datetime"
      render_datetime(f, name)
    else
      return "ERROR: field could not be rendered #{name} #{data_type}"
    end
  end

  def render_text_field(f, name)
    ret = "<div class=\"field\">"
    ret += f.label name.to_sym
    ret += f.text_field name.to_sym
    ret += "</div>"
    return ret
  end

  def render_text_area(f, name)
    ret = "<div class=\"field\">"
    ret += f.label name.to_sym
    ret += f.text_area name.to_sym, rows: 4
    ret += "</div>"
    return ret
  end

  def render_boolean(f, name)
    ret = "<div class=\"field\">"
    ret += f.label name.to_sym
    ret += "No"
    ret += f.radio_button name.to_sym, "0"
    ret += "Yes"
    ret += f.radio_button name.to_sym, "1"
    ret += "</div>"
    return ret
  end

  def render_datetime(f, name)
    ret = "<div class=\"field\">"
    ret += f.label name.to_sym
    ret += f.date_select name.to_sym
    ret += "</div>"
    return ret
  end

end
