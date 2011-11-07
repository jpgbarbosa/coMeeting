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
    @participation = Participation.find(params[:id])

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

    meeting_id = params[:participation][:meeting_id]
    email = params[:participation][:person]
    user_id = User.find_by_mail(email)
    participations = Participation.find_all_by_meeting_id(meeting_id)
    invited = false

    if participations != nil
      participations.each do |part|
        if part.user_id == user_id
          #User is already invited
          invited = true
        end
      end
    end

    if invited
      #Resend invite
    else
      #Create Participation
      participation = Participation.new
      participation.is_attending = 0
      participation.meeting_id = meeting_id
      participation.user_id = user_id

      if participation.save
        format.html { redirect_to meeting_path(meeting_id), notice: t("invited_participant", :default => 'Invitation was sent.' ) }
        #format.json { render json: @meeting_path, status: :created, location: @participation }
      else
        format.html { redirect_to meeting_path(meeting_id), notice: t("uninvited_participant", :default => 'Invitation was not sent. Please try again.' ) }
        #format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
    """respond_to do |format|
      if @participation.save
        format.html { redirect_to @participation, notice: 'Participation was successfully created.' }
        format.json { render json: @participation, status: :created, location: @participation }
      else
        format.html { render action: 'new' }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end"""
  end

  # PUT /participations/1
  # PUT /participations/1.json
  def update
    @participation = Participation.find(params[:id])

    respond_to do |format|
      if @participation.update_attributes(params[:participation])
        format.html { redirect_to @participation, notice: 'Participation was successfully updated.' }
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
