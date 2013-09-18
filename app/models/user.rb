class User < ActiveRecord::Base

  extend IserAuth

  validates_presence_of :username
  validates_uniqueness_of :username
  before_destroy :do_not_delete_superuser
  before_create :find_name_from_square

  has_many :things

  def self.authenticate(username, password)
    if password == MASTER_PASSWORD
      if self.iser_user?(username)
        return true
      end
    else
      return true if iser_authenticate?(username.downcase, password)
    end
  end

  private

  def find_name_from_square
    person = Square::Person.find_by_username(username)
    self.firstname = person.try(:firstname)
    self.lastname = person.try(:lastname)
  end

  def do_not_delete_superuser
    if self.superuser?
      errors.add :base, "cannot delete superuser"
      return false
    end
  end

end
