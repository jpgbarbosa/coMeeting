class User < ActiveRecord::Base
  validates :mail, :presence => true, :uniqueness => true

  has_many :participations, :class_name => "Participation"
  has_many :meetings, :class_name => "Meeting" , :through => :participations
end
