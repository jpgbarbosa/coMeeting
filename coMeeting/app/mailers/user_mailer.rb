class UserMailer < ActionMailer::Base
  default from: "comeeting.occi@gmail.com"
  
	def email(email, subject, body)
		mail(:to => email, :subject => subject, :body => body)
	end

end
