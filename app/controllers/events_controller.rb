class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def set_attendance
    # Check if record already exists
    @event_user = EventUser.find_by(user_id: current_user.id, event_id: params['event_id'])
    unless @event_user
      @event_user = EventUser.new
      @event_user.event_id = params['event_id']
      @event_user.user_id = current_user.id
    end
    @event_user.attending = params['attending']
    @event_user.save
    redirect_back(fallback_location: event_path(id: params['event_id']))
  end

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    if params['event_id']
      @selected_event = Event.find_by(id: params['event_id'])
    end
    @selected_event ||= Event.last
    event_user = EventUser.find_by(user_id: current_user.id, event_id: @selected_event.id)
    @attending = event_user ? event_user.attending : nil
  end

  # GET /events/1
  # GET /events/1.json
  def show
    # @event_details = MeetupService.event(@event.group.urlname, @event.meetup_id)
    @event_details = {}
    @ratings = { food: 0, drinks: 0, talks: 0, vibe: 0 }
    event_user = EventUser.find_by(user_id: current_user.id, event_id: @event.id)
    @attending = event_user ? event_user.attending : nil
  end

  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if @event.update(event_params)
      format.html { redirect_to @event, notice: 'event was successfully updated.' }
    else
      format.html { render :edit }
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :date)
    end
end
