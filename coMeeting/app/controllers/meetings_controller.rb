class MeetingsController < ApplicationController

	def index
		@meetings = Meeting.all

		respond_to do |format|
			format.html { render html: @meetings } # index.html.erb
			format.json { render json: @meetings }
		end
	end


	def show
		@meeting = Meeting.find_by_token(params[:id])
		
		if @meeting.nil?
			participation = Participation.find_by_token(params[:id])
			
			if !participation.nil?
				@meeting = Meeting.find(participation.meeting_id)
				@minutes = @meeting.minutes
				@static_minutes = create_static_minutes(@meeting)
				@admin = false
			end
		else
			@static_minutes = create_static_minutes(@meeting)
			@admin = true
		end
		
		respond_to do |format|
			if @meeting.nil?
				flash[:error] = t("meeting.error.show", :default => "The meeting you're looking for doesn't exist!")
				format.html { redirect_to root_path }
			else
				format.html # show.html.erb
				format.json { render json: @meeting }
			end
		end
	end


	def new
		@meeting = Meeting.new
		time = Time.new
		@current_date = time.day.to_s + '/' + time.month.to_s + '/' + time.year.to_s

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @meeting }
		end
	end


	def create
		params[:meeting][:topics].reject!( &:blank? )
		params[:participations].reject!( &:blank? )

		@meeting = Meeting.new(params[:meeting])
		@meeting.token = UUIDTools::UUID.random_create().to_s
		@meeting.timezone = ActiveSupport::TimeZone.zones_map[params[:timezone]].to_s

		respond_to do |format|
			if @meeting.save
				params[:participations].each do |email|
					user = User.find_by_mail(email)
					if user.nil?
						user = User.new(:mail => email)
						user.save
					end

					participation = Participation.new(:meeting_id => @meeting.id, :user_id => user.id, :token => UUIDTools::UUID.random_create().to_s)
					if participation.save
						UserMailer.email(email, t("email.participant.subject", :admin => params[:admin][:name], :default => "You were invited by #{params[:admin][:name]} for a meeting"), "#{ENV['HOST']}/#{params[:locale]}/meetings/#{participation.token}").deliver
					end
				end

				if params[:meeting][:admin].empty?
					format.html { redirect_to meeting_path(@meeting.token), notice: t("meeting.created.withoutauth", :default => "Meeting successfully created without email confirmation.") }
					format.json { head :ok }
				else
					admin = User.find_by_mail(params[:meeting][:admin])
					if admin.nil?
						admin = User.new(:mail => params[:meeting][:admin])
						admin.save
					end
					
					UserMailer.email(params[:meeting][:admin], t("email.admin.subject", :admin => params[:admin][:name], :default => "#{params[:admin][:name]}, here's your meeting administration link"), "#{ENV['HOST']}/#{params[:locale]}/meetings/#{@meeting.token}").deliver
					format.html { redirect_to root_path, notice: t("meeting.created.withauth", :default => "Meeting successfully created. Please check your email to continue the creation process.") }
					format.json { head :ok }
				end
			else
				format.html { render action: "new" }
				format.json { render json: @meeting.errors, status: :unprocessable_entity }
			end
		end
	end


	def edit
		@meeting = Meeting.find_by_token(params[:id])

		if @meeting.nil?
			respond_to do |format|
				flash[:error] = t("meeting.error.show", :default => "The meeting you're looking for doesn't exist!")
				format.html { redirect_to root_path }
			end
		else
			@participations = @meeting.participations
			respond_to do |format|
				format.html # edit.html.erb
				format.json { render json: @meeting }
			end
		end
	end
    
    
	def update
    	params[:meeting][:topics].reject!( &:blank? )
		params[:participations].reject!( &:blank? )
        
		@meeting = Meeting.find_by_token(params[:id])
		
		@meeting.timezone = ActiveSupport::TimeZone.zones_map[params[:timezone]].to_s
		@meeting.save
		meeting_updated = @meeting.update_attributes(params[:meeting])
		
		if meeting_updated	
			participations = @meeting.participations

			participations.each do |participation|
				unless params[:participations].include?(participation.user.mail)
					participation.destroy
				end
			end

			params[:participations].each do |email|
				puts 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
				puts email
				user = User.find_by_mail(email)
				if user.nil?
					user = User.new(user.mail => email)
					user.save
				end

				participation = participations.find_by_user_id(user.id)
				if participation.nil?
					participation = Participation.new(:meeting_id => @meeting.id, :user_id => user.id, :token => UUIDTools::UUID.random_create().to_s)
					puts 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
					if participation.save
						puts 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY'
						name = "Guilherme"
						UserMailer.email(email, t("email.participant.subject", :admin => name, :default => "You were invited by #{name} for a meeting"), "#{ENV['HOST']}/#{params[:locale]}/meetings/#{participation.token}").deliver
					end
				end
			end
		end

		respond_to do |format|
			if meeting_updated
				format.html { redirect_to meeting_path(@meeting.token), notice: t("meeting.updated", :default => "Meeting successfully updated.") }
				format.json { head :ok }
			else
				format.html { render action: "edit" }
				format.json { render json: @meeting.errors, status: :unprocessable_entity }
			end
		end
	end


	def destroy
		meeting = Meeting.find_by_token(params[:id])

		if meeting == nil
			respond_to do |format|
				flash[:error] = t("meeting.error.delete", :default => "The meeting you tried deleting doesn't exist!")
				format.html { redirect_to root_path }
			end
		else
			meeting.destroy
			respond_to do |format|
				format.html { redirect_to root_path, notice: t("meeting.deleted", :default => "Meeting successfully deleted.") }
				format.json { head :ok }
			end
		end
	end

	def update_action_item
		participation = Participation.find_by_id(params[:id])

		participation.update_attributes(:action_item => params[:action_item], :deadline => params[:deadline])

		meeting = Meeting.find_by_id(participation.meeting_id)
				
		@static_minutes = create_static_minutes(meeting)

		respond_to do |format|
			format.js
		end
	end

    def update_minutes
        meeting = Meeting.find_by_token(params[:id])

		meeting.update_attribute(:minutes, params[:minutes])

        render :nothing => true
    end


    def get_minutes
		meeting = Meeting.find_by_token(params[:id])
		
		@static_minutes = create_static_minutes(meeting)
		
		@minutes = meeting.minutes
		
        respond_to do |format|
			format.js
		end
    end

	respond_to :js
	def get_admin_circles
		user = User.find_by_mail(params[:mail])

		@data = ""
		user.circles.each do |u|
			mail = User.find_by_id(u).mail
			if mail.include?(params[:term])
				@data = @data + mail.to_s
				@data = @data + ", "
			end
		end

		respond_with(@data)
	end


	def download_pdf
		meeting = Meeting.find_by_token(params[:id])

		static_minutes = create_static_minutes(meeting)

		my_file = "tmp/minutes_#{UUIDTools::UUID.random_create()}.pdf"

		Prawn::Document.generate(my_file) do
			text static_minutes + (meeting.minutes.nil? ? "" : "\n\n" + meeting.minutes)
		end

		send_file my_file
	end	
	
	protected
	def create_static_minutes(meeting)

		topics = ""
		participants = ""
		action_items = ""

		meeting.topics.each do |topic|
			topics += "- " + topic + "\n\t"
		end

		meeting.participations.each do |participation|
			participants += "- " + participation.user.mail + "\n\t"
			if !participation.action_item.nil? && !participation.deadline.nil?
				action_items += "\n\t- " + participation.user.mail + " => " + participation.action_item.to_s + " " + t('until') + " " + participation.deadline.to_s
			end
		end

		minutes = "\n" + t("subject") + ": " + meeting.subject +
			"\n" + t("local") + ": " + meeting.local +
			"\n" + t("date") + ": " + meeting.meeting_date.to_s +
			"\n" + t("time") + ": " + meeting.meeting_time.strftime("%1Hh:%Mm").to_s + " " + meeting.timezone +
			"\n" + t("duration") + ": " + meeting.duration.strftime("%1Hh:%Mm").to_s +
			"\n" + t("extra_info") + ": " + meeting.extra_info +
			"\n" + t("administrator_email") + ": " + meeting.admin +
			"\n\n\t" + t("topics") + ":" +
			"\n\t" + topics +
			"\n\t" + t("participants") + ":" +
			"\n\t" + participants +
			"\n\t" + t("actions") + ":" + action_items
			
		return minutes
	end
	
end
