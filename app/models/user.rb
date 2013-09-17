class User < ActiveRecord::Base

  extend IserAuth

  validates_presence_of :username
  validates_uniqueness_of :username

  def self.authenticate(username, password)
    if password == MASTER_PASSWORD
      if self.iser_user?(username)
        return true
      end
    else
      return true if iser_authenticate?(username.downcase, password)
    end
  end

end
