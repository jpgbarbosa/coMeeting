class UserMailer < ActionMailer::Base
  default from: "coMeeting@comeeting.com"

  #é para apagar o campo email, e passar a receber só o admin (que é um user). Para aceder ao campo email, é só fazer admin[:email]
  def admin_email(email, admin, token)
  	mail(:to => email, :subject => t("email.admin.subject", :default => "Your administration link"), :body => "#{ENV['HOST']}/meetings/#{token}")
  end

  def invitation_email(email, admin, token)
    mail(:to => email, :subject => t("email.participant.subject", :default => "You were invited by #{admin[:name]} for a meeting"), :body => "#{ENV['HOST']}/meetings/#{token}")
  end

end
