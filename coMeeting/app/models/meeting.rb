class Meeting < ActiveRecord::Base
  serialize :topics, Array

  validates :subject, :presence => true
  validates :local, :presence => true
  validates :meeting_date, :presence => true

  has_many :participations, :class_name => "Participation"
  has_many :users, :class_name => "User", :through => :participations
  
  after_initialize :init
  
  def init
	self.verified ||= false
	self.admin ||= -1
  end
  
  
end
