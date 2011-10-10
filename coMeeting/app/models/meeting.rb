class Meeting < ActiveRecord::Base

  serialize :topics, Array
  attr_accessor :timezone

  validates :subject, :presence => true
  validates :local, :presence => true
  validates :meeting_date, :presence => true
  validates :admin, :presence => true

  has_many :participations
  has_many :users, :through => :participations
end
