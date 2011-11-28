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
    #@participation = Participation.new(params[:participation])
	
    meeting_id = params[:meeting_id]
    meeting = Meeting.find_by_link_admin(meeting_id)
    email = params[:person]
    user = User.find_by_mail(email)
    participations = Participation.find_all_by_meeting_id(meeting.id)

    invited = false
    user_id = -1

    if participations != nil && user != nil
      user_id = user.id
      participations.each do |part|
        if part.user_id == user_id
          #User is already invited
          invited = true
          @participation = part
          break
        end
      end
    end

    if invited
      #Resend invite

      #CHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANGEEEEEEEEEEEE THISSSSSSSSSSSSSSS
      #UserMailer.invitation_email(email, @participation.token).deliver
      respond_to do |format|
        format.html { redirect_to meeting_path(meeting_id), notice: t("participant.reinvited", :default => "Invitation resent.") }
        #format.json { render json: @meeting_path, status: :created, location: @participation }
      end

    else
      #Create Participation
      @participation = Participation.new
      @participation.is_attending = 0
      @participation.meeting_id = meeting.id
      if user_id == -1
        user = User.new
        user.mail = email
        user.save

        user_id = user.id
      end

      @participation.user_id = user_id
      @participation.token = UUIDTools::UUID.random_create().to_s

      #CHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANGEEEEEEEEEEEE THISSSSSSSSSSSSSSS
      #UserMailer.invitation_email(email, @participation.token).deliver


      respond_to do |format|
        if @participation.save
          format.html { redirect_to meeting_path(meeting_id), notice: t("participant.invited", :default => "Invitation sent.") }
          #format.json { render json: @meeting_path, status: :created, location: @participation }
        else
          format.html { redirect_to meeting_path(meeting_id), notice: t("participant.uninvited", :default => "Invitation not sent. Please try again.") }
          #format.json { render json: @participation.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /participations/1
  # PUT /participations/1.json
  def update
    @participation = Participation.find_by_token(params[:id])

    b = params[:b]

    if b == 'y'
      @participation.is_attending = 1
    elsif b == 'n'
      @participation.is_attending = -1
    end

    respond_to do |format|
      if (b == 'y' || b == 'n') && (@participation.save)
        format.html { redirect_to participation_path(@participation.token), notice: t("participant.updated", :default => "Participation successfully updated.") }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
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
end
