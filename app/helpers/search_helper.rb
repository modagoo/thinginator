module SearchHelper

  def thing_attributes_list(thing)
    # ignore_attributes = [:id, :_index, _version, _score, sort, _explanation, _type]
    ignore_attributes = [:collection, :collection_name, :id, :_index, :_version, :_score, :sort, :highlight, :_type, :_explanation]
    ret = []
    thing.to_hash.each do |k,v|
      ret << "#{k}: <strong>#{v}</strong>" unless ignore_attributes.include?(k)
    end
    ret.join(", ").html_safe
  end

end
