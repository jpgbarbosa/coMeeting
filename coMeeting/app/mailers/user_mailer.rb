class UserMailer < ActionMailer::Base
  default from: "coMeeting@comeeting.com"

  def admin_email(email, subject, token)
  	mail(:to => email, :subject => subject, :body => "http://localhost:3000/meetings/"+ token)
  end
end
