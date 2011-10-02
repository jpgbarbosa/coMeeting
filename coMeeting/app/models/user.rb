class User < ActiveRecord::Base
  validates :mail, :presence => true, :uniqueness => true

  has_many :participations
  has_many :meetings, :through => :participations
end
