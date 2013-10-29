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
    when "Date"
      render_date(f, p)
    when "Time"
      render_time(f, p)
    when "File"
      render_file_field(f, p)
    when "Markdown"
      render_markdown_field(f, p)
    when "List"
      render_list_field(f, p)
    else
      return "ERROR: field could not be rendered #{p.slug} #{p.data_type.name}"
    end
  end

  def render_text_field(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym, "#{p.name}#{' *' if p.validations.any?}"
    ret += f.text_field p.slug.to_sym
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_text_area(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym, "#{p.name}#{' *' if p.validations.any?}"
    ret += f.text_area p.slug.to_sym, rows: 4
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_boolean(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym, "#{p.name}#{' *' if p.validations.any?}"
    ret += f.select p.slug.to_sym, [['Yes', true], ['No', false]], prompt: true
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_datetime(f, p)
    ret = "<div class=\"field datetimepicker input-append date\" >"
    ret += f.label p.slug.to_sym, "#{p.name}#{' *' if p.validations.any?}"
    ret += f.text_field p.slug.to_sym, :'data-format' => "dd/MM/yyyy hh:mm", readonly: 'readonly'
    ret += "<span class=\"add-on\">"
    ret += "<i data-date-icon=\"fa fa-calendar\" data-time-icon=\"fa fa-clock-o\" class=\"fa fa-clock-o\"></i>"
    ret += "</span>"
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_date(f, p)
    ret = "<div class=\"field datepicker input-append date\" >"
    ret += f.label p.slug.to_sym, "#{p.name}#{' *' if p.validations.any?}"
    ret += f.text_field p.slug.to_sym, :'data-format' => "dd/MM/yyyy", readonly: 'readonly'
    ret += "<span class=\"add-on\">"
    ret += "<i data-date-icon=\"fa fa-calendar\" data-time-icon=\"fa fa-clock-o\" class=\"fa fa-clock-o\"></i>"
    ret += "</span>"
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_time(f, p)
    ret = "<div class=\"field timepicker input-append date\" >"
    ret += f.label p.slug.to_sym, "#{p.name}#{' *' if p.validations.any?}"
    ret += f.text_field p.slug.to_sym, :'data-format' => "hh:mm", readonly: 'readonly'
    ret += "<span class=\"add-on\">"
    ret += "<i data-date-icon=\"fa fa-calendar\" data-time-icon=\"fa fa-clock-o\" class=\"fa fa-clock-o\"></i>"
    ret += "</span>"
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_file_field(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym, "#{p.name}#{' *' if p.validations.any?}"
    ret += f.file_field p.slug.to_sym
    ret += content_tag :p, p.help, class: "help"
    ret += content_tag :p, (link_to "<i class=\"icon-download-alt\"></i> #{f.object.send(p.slug.to_sym).send(:original_filename)}".html_safe, f.object.send(p.slug.to_sym).to_s, class: 'btn btn-small'), class: "help" if f.object.send(p.slug.to_sym).present?
    ret += "</div>"
    return ret
  end

  def render_markdown_field(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym, "#{p.name}#{' *' if p.validations.any?}"
    ret += f.text_area p.slug.to_sym
    ret += content_tag :p, p.help, class: "help"
    ret += "</div>"
    return ret
  end

  def render_list_field(f, p)
    ret = "<div class=\"field\">"
    ret += f.label p.slug.to_sym, "#{p.name}#{' *' if p.validations.any?}"
    if p.data_lists.first.multiple?
      ret += render_multi_checkboxes(f,p)
    else
      ret += render_select(f,p)
    end
    ret += "</div>"
    return ret
  end

  def render_multi_checkboxes(f,p)
    ret = "<ol class=\"multi\">"
    p.data_lists.first.list.list_values.each do |list_item|
      ret += content_tag :li do
        concat("<label>#{list_item.value}".html_safe)
        concat(f.check_box(p.slug.to_sym, { :multiple => true }, list_item.id.to_s, nil))
        concat("</label>".html_safe)
      end
    end
    ret += "</ol>"
    ret
  end

  # TODO : Oh golly gosh, this don't look nice
  def render_select(f,p)
    f.collection_select(p.slug.to_sym, ListValue.find(p.data_lists.first.list.list_values.collect{|v| v.id}), :id, :value, prompt: true)
  end

  def render_thing(thing, p)
    case p.data_type.name
    when "File"
      if thing.send(p.slug.to_sym).present?
        fpath = thing.send(p.slug.to_sym)
        oname = fpath.send(:original_filename)
        fprint = fpath.send(:fingerprint)
        unless fpath.blank?
          content_tag :p, class: 'no-margin' do
            concat(link_to "<i class=\"icon-download-alt\"></i> #{oname}".html_safe, fpath.to_s, class: 'btn btn-small')
            concat(content_tag :span, "md5: #{fprint}", class: 'info no-margin')
          end
        end
      else
        content_tag :p, "No file", class: 'info'
      end
    when "Markdown"
      markdown(thing.send(p.slug.to_sym).to_s)
    when "List"
      v = thing.send(p.slug.to_sym)
      if v.present?
        if v.is_a?(String)
          ListValue.find(v).value
        elsif v.is_a?(Array)
          v.collect{ |l| ListValue.find(l).value }.join(", ")
        end
      end
    else
      thing.send(p.slug.to_sym).to_s
    end
  end

end
