class MembershipInvitation < ActiveRecord::Base
validates_uniqueness_of :user_id, :scope => :group_id
  belongs_to :group
  belongs_to :user
end
