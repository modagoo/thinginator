module SearchHelper

  def thing_attributes_list(thing)
    ignore_attributes = [:collection, :collection_name, :id, :_index, :_version, :_score, :sort, :highlight, :_type, :_explanation]
    ret = []
    thing.to_hash.each do |k,v|
      if v.present?
        if v.is_a?(String)
          ret << "#{k}: <strong>#{truncate(v, length: 255)}</strong>" unless ignore_attributes.include?(k)
        else
          ret << "#{k}: <strong>#{v}</strong>" unless ignore_attributes.include?(k)
        end
      end
    end
    ret.join(", ").html_safe
  end

  def paginate_search_results(results,q)
    total = results.total_entries.to_f
    current_page = results.current_page.to_f
    total_pages = (total / SEARCH_PAGE_SIZE).ceil
    visible = (0..total_pages - 1).to_a
    if total_pages > 5
      pages = visible.select{|page| (current_page - 3..current_page + 3) === page }
      unless pages.include?(visible.first)
        pages.unshift(-1) # insert divider element, gets rendered as …
        pages.unshift(0)
      end
      unless pages.include?(visible.last)
        pages << (-1) # insert divider element, gets rendered as …
        pages << (visible.last)
      end
    else
      pages = visible
    end
    if pages.size > 1
      ret = "<div class=\"pagination\">"
      pages.each do |i|
        if i == -1
          ret += "<span class=\"break\">&hellip;</span>"
        else
          if (i + 1) == current_page
            ret += "<em>"
          else
            ret += "<a href=\"/search?q=#{q}&page=#{(i + 1).to_s}"
            ret += "&t=#{params[:t]}" if params[:t].present?
            ret += "\">"
          end
          ret += "#{ (i + 1).to_s }"
          if (i + 1) == current_page
            ret += "</em>"
          else
            ret += "</a>"
          end
        end
      end
      ret += "</div>"
      ret.html_safe
    else
      ""
    end

  end
end
