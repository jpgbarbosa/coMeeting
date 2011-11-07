class Participation < ActiveRecord::Base
  validates :is_attending, :presence => true
  validates :token, :presence => true, :uniqueness => true

  belongs_to :meeting, :class_name => "Meeting"
  belongs_to :user, :class_name => "User"
end
