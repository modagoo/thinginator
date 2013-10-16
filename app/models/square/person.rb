require 'nokogiri'
require 'open-uri'

module Square

  class Person < ActiveResource::Base

    self.site = "https://iseriwww.essex.ac.uk:443/people/"
    ActiveResource::Base.format = :xml

    def self.find_by_username(username)
      first(:from => :remote_find_by_email, :params => {:email => "#{username}@essex.ac.uk", :login => "jc@seyss.com"})
    end

    def fullname
      "#{firstname} #{lastname}"
    end

    def self.find_all
      all(from: :iser_current)
    end

  end

end
