class SearchController < ApplicationController
  def index
    pagesize = SEARCH_PAGE_SIZE
    q = sanitize_string_for_elasticsearch_string_query(params[:q])
    t = params[:t]
    p = params[:page]
    if q.present?
      if p.blank?
        offset = 0
      else
        offset = pagesize * (p.to_i - 1)
      end
      r = Thing.search do
        query do
          string q
        end
        if t.present?
          filter :term, :type => t
        end
        facet 'type', :global => false do
          terms :type,
          size: 999
        end
        from offset
        size pagesize
      end
      @results = r
    end
  end

  private

  # http://stackoverflow.com/questions/16205341/symbols-in-query-string-for-elasticsearch
  def sanitize_string_for_elasticsearch_string_query(str)
    # Escape special characters
    # http://lucene.apache.org/core/old_versioned_docs/versions/2_9_1/queryparsersyntax.html#Escaping Special Characters
    escaped_characters = Regexp.escape('\\+-&|!(){}[]^~?:')
    str = str.gsub(/([#{escaped_characters}])/, '\\\\\1')

    # AND, OR and NOT are used by lucene as logical operators. We need
    # to escape them
    ['AND', 'OR', 'NOT'].each do |word|
      escaped_word = word.split('').map {|char| "\\#{char}" }.join('')
      str = str.gsub(/\s*\b(#{word.upcase})\b\s*/, " #{escaped_word} ")
    end

    # Escape odd quotes
    quote_count = str.count '"'
    str = str.gsub(/(.*)"(.*)/, '\1\"\3') if quote_count % 2 == 1

    str
  end

  # # http://stackoverflow.com/a/16442439/227053 - PG 14-05-2013
  # def sanitize_string_for_elasticsearch_string_query(str)
  #   return "" if str.blank?
  #   # Escape special characters
  #   escaped_characters = Regexp.escape('\\+-:()[]{}!')
  #   str = str.gsub(/([#{escaped_characters}])/, '\\\\\1')

  #   # Replace AND, OR, NOT (note the upper case) with lower case equivalent when surrounded by word boundaries
  #   ['and', 'or', 'not'].each do |word|
  #     escaped_word = word.split('').map {|char| "\\#{char}" }.join('')
  #     str = str.gsub(/\s*\b(#{word.upcase})\b\s*/, " #{escaped_word} ")
  #   end

  #   # Remove odd quotes
  #   quote_count = str.count '"'
  #   str = str.gsub(/(.*)"(.*)/, '\1\"\3') if quote_count % 2 == 1

  #   str
  # end

end
