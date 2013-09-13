module ThingsHelper

  def render_form_fields(f, properties)
    ret = ""
    properties.each do |p|
      ret << render_field(f, p)
    end
    ret.html_safe
  end

  def render_field(f, p)
    case p.data_type.name
    when "Fixnum"
      render_text_field(f, p)
    when "String"
      render_text_field(f, p)
    when "Text"
      render_text_area(f, p)
    when "Boolean"
      render_boolean(f, p)
    when "Datetime"
      render_datetime(f, p)
    when "File"
      render_file_field(f, p)
    else
      return "ERROR: field could not be rendered #{p.slug} #{p.data_type.name}"
    end
  end

  def render_text_field(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym
    ret += f.text_field p.slug.to_sym
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_text_area(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym
    ret += f.text_area p.slug.to_sym, rows: 4
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_boolean(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym
    ret += f.select p.slug.to_sym, [['Yes', true], ['No', false]], prompt: true
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_datetime(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym
    ret += f.date_select p.slug.to_sym
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_file_field(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym
    ret += f.file_field p.slug.to_sym
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_thing(thing, p)
    case p.data_type.name
    when "File"
      fpath = thing.send(p.slug.to_sym).to_s
      link_to File.basename(fpath.gsub(/\?.*\z/,"")), fpath, class: 'btn btn-small' unless fpath.blank?
    else
      thing.send(p.slug.to_sym)
    end
  end

end
