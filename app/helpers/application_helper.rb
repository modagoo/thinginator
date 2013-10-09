module ApplicationHelper

  def setting(name)
    if s = Setting.find_by(slug: name.to_s)
      ret = s.value.present? ? s.value : ""
    else
      ret = ""
    end
    ret
  end

  def active?(str)
    if controller.controller_name == str
      return { class: 'active'}
    end
  end

  def pluralize_without_count(count, noun, text = nil)
    if count != 0
      count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
    end
  end

  def render_flash(flash)
    if flash.present?
      if flash.notice.present?
        return content_tag :p, class: 'notice' do
          concat(content_tag :span, flash.notice)
          concat(content_tag :button, "x", class: 'close', 'data-dismiss' => 'alert')
        end
      end
      if flash.alert.present?
        return content_tag :p, class: 'alert' do
          concat(content_tag :span, flash.alert)
          concat(content_tag :button, "x", class: 'close', 'data-dismiss' => 'alert')
        end
      end
    end
  end

  def errors_for(object)
    # return object.errors.inspect
    ret = ""
    if object.errors.any?
      ret += "<div id=\"error_explanation\">"
      ret += "<h2>Please check #{pluralize(object.errors.count, 'error')}:</h2>"
      ret +=  "<ul>"
      object.errors.full_messages.each do |msg|
        ret += "<li>#{msg}</li>"
      end
      ret += "</ul>"
      ret += "</div>"
      ret.html_safe
    end
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

  def build_data_fields(f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    { id: id, fields: fields.gsub("\n", "") }
  end

  def link_to_remove_fields(label, f, css="")
    ret = ""
    ret += f.hidden_field :_destroy , class: 'remove_fields'
    ret += link_to(label, '#', class: "remove_fields #{css}")
    ret.html_safe
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, filter_html: true, no_intraempahais: true, fenced_code_blocks: true, disable_indented_code_blocks: true, autolink: true, space_after_headers: true)
    markdown.render(text).html_safe
    # syntax_highlighter(markdown.render(text)).html_safe
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    # doc.search("//pre[@lang]").each do |pre|
    doc.search("//pre/code[@class]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:class])
    end
    doc.to_s
  end

end
