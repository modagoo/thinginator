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

end
