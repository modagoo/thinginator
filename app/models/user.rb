class User < ActiveRecord::Base

  extend IserAuth

  validates_presence_of :username
  validates_uniqueness_of :username
  before_destroy :do_not_delete_superuser
  before_create :find_name_from_square
  validate :is_iser?

  has_many :things
  has_many :collections
  has_many :data_types
  has_many :validation_types

  def self.authenticate(username, password)
    return true
    if password == MASTER_PASSWORD
      if self.iser_user?(username)
        return true
      end
    else
      return true if iser_authenticate?(username.downcase, password)
    end
  end

  def fullname
    "#{firstname} #{lastname}"
  end

  private

  def is_iser?
    # errors.add :username, "is not an ISER member" unless User.iser_user?(username)
  end

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
