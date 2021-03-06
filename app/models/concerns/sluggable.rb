module Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :create_slug
    validates :name, exclusion: { in: %w(__FILE__ __LINE__ BEGIN END alias test and begin break case class def defined? do else elsif end ensure for if in module next nil not or redo rescue retry return self super then undef unless until when while yield) }
  end

  def create_slug
    if slug.blank?
       clean_path = name.downcase.gsub(/[^a-z0-9]+/i, '_')
       my_url = clean_path.gsub(/(_)\z/, '')
       my_url = my_url.gsub(/^(_)/, '')
       self.slug = my_url
    end
  end

end
