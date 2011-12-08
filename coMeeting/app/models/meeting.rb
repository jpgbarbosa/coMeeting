class Meeting < ActiveRecord::Base
  serialize :topics, Array

  validates :subject, :presence => true
  validates :local, :presence => true
  validates :meeting_date, :presence => true

  has_many :participations, :class_name => "Participation"
  has_many :users, :class_name => "User", :through => :participations
end
