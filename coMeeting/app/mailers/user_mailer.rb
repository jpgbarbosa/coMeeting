class UserMailer < ActionMailer::Base
  default from: "coMeeting@comeeting.com"

  def admin_email(email, token)
  	mail(:to => email, :subject => t("admin_subject", :default => "Your administration link"), :body => "#{url_for(:host)}/meetings/#{token}")
  end

  def invitation_email(email, token)
    mail(:to => email, :subject => t("participant_invitation", :default => "Meeting Invitation"), :body => "#{url_for(:host)}/meetings/#{token}")
  end

end
