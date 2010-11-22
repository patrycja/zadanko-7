class Group < ActiveRecord::Base
has_many :memberships, :dependent => :destroy
has_many :users, :through => :memberships

validates_length_of :name, :maximum => 50
validates_length_of :description, :maximum => 75
validates_presence_of :name, :description


  def admins
    return memberships.where(:admin => true).map {|t| t.user}
  end
  
  def admin?(user)
      return admins.include?(user)
  end
  
  def members
    return memberships.map {|t| t.user.email}
  end
  
  def member?(user)
      return users.include?(user)
  end
end
