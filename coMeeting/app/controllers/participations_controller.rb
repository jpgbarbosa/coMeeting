class ParticipationsController < ApplicationController
  # GET /participations
  # GET /participations.json
  def index
    @participations = Participation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participations }
    end
  end

  # GET /participations/1
  # GET /participations/1.json
  def show
    @participation = Participation.find_by_token(params[:id])

    @meeting = Meeting.find(@participation.meeting_id)

    if @meeting != nil
      @participations = @meeting.participations
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participation }
    end
  end

  # GET /participations/new
  # GET /participations/new.json
  def new
    @participation = Participation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participation }
    end
  end

  # GET /participations/1/edit
  def edit
    @participation = Participation.find(params[:id])
  end

  # POST /participations
  # POST /participations.json
  def create

  end

  # PUT /participations/1
  # PUT /participations/1.json
  def update
    participation = Participation.find_by_token(params[:id])

    b = params[:b]

    if b == 'y'
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
		
    elsif b == 'n'
		participation.is_attending = -1
    end

    respond_to do |format|
      if (b == 'y' || b == 'n') && (participation.save)
        format.html { redirect_to meeting_path(participation.token), notice: t("participant.updated", :default => "Participation successfully updated.") }
        format.json { head :ok }
      else
        format.html { redirect_to meeting_path(participation.token) }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @participation = Participation.find(params[:id])
    @participation.destroy

    respond_to do |format|
      format.html { redirect_to participations_url }
      format.json { head :ok }
    end
  end
  
  def send_email
    participation = Participation.find(params[:id])	
	UserMailer.invitation_email(participation.user.mail, participation.token).deliver
	render :nothing => true
  end
  
  
  
end
