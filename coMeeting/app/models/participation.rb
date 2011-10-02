class Participation < ActiveRecord::Base
  validates :is_attending, :presence => true

  belongs_to :meeting
  belongs_to :user
end
