class ParticipationsController < ApplicationController
	def confirm
		participation = Participation.find_by_token(params[:id])
		
		meeting = Meeting.find_by_id(participation.meeting_id)
		participations = meeting.participations
		admin = User.find_by_mail(meeting.admin)
	  
		if !admin.nil?
			participations.each do |participant|
				if participant.is_attending == 1
					if !participant.user.circles.include?(participation.user.id)
						participant.user.circles << participation.user.id
						participation.user.circles << participant.user.id
					end
				end
				participant.user.save
			end
			if !admin.circles.include?(participation.user.id)
				admin.circles << participation.user.id
				participation.user.circles << admin.id
				participation.user.save
				admin.save
			end
		end
		
		participation.is_attending = 1
	
		respond_to do |format|
			if participation.save
				format.html { redirect_to meeting_path(participation.token), notice: t("attending.notice.confirm", :default => "Successfully confirmed attendance.") }
				format.json { head :ok }
			else
				format.html { redirect_to meeting_path(participation.token) }
				format.json { render json: @participation.errors, status: :unprocessable_entity }
			end
		end
	end
	
	
	
	def decline
		participation = Participation.find_by_token(params[:id])
		
		participation.is_attending = -1

		respond_to do |format|
			if participation.save
				format.html { redirect_to meeting_path(participation.token), notice: t("attending.notice.decline", :default => "Successfully declined attendance.") }
				format.json { head :ok }
			else
				format.html { redirect_to meeting_path(participation.token) }
				format.json { render json: @participation.errors, status: :unprocessable_entity }
			end
		end
	end
	
	
	def send_email
		participation = Participation.find(params[:id])
		admin = User.find(participation.meeting.admin)
		name = get_name_from(admin)
		UserMailer.email(participation.user.mail, t("email.participant.subject", :admin => name, :default => "You were invited by #{name} for a meeting"), t("email.participant.body", :link => "#{ENV['HOST']}/#{params[:locale]}/meetings/#{participation.token}") ).deliver
		render :nothing => true
	end
end
