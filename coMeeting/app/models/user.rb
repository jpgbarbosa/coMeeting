class User < ActiveRecord::Base
  serialize :circles, Array
  validates :mail, :presence => true, :uniqueness => true

  has_many :participations, :class_name => "Participation"
  has_many :meetings, :class_name => "Meeting" , :through => :participations
  
  def circle_email
	
  end
  
end
