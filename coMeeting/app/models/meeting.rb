class Meeting < ActiveRecord::Base

  serialize :topics

  validates :subject, :presence => true
  validates :local, :presence => true
  validates :date, :presence => true
  validates :admin, :presence => true

  has_many :participations
  has_many :users, :through => :participations
end
