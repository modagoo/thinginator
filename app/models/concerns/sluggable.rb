module Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :create_slug
  end

  def create_slug
    if slug.blank?
       clean_path = name.downcase.gsub(/[^a-z0-9]+/i, '-')
       my_url = clean_path.gsub(/(-)\z/, '')
       my_url = my_url.gsub(/^(-)/, '')
       self.slug = my_url
    end
  end

end
