class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]

  def search
    @results = MeetupService.groups(params[:search_text], params[:location])
    @group = Group.new
    render 'new'
  end

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
  end

  # POST /groups
  # POST /groups.json
  def create
    # byebug
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
      generate_events(@group.urlname)
    else
      redirect_to groups_path, alert: 'Group already exists.'
    end
  end

  # PATCH/PUT /groups/1
  def update
    data = MeetupService.group(@group[:urlname])
    if @group.update(name: data['name'],
                     urlname: data['urlname'],
                     description: data['description'],
                     location: data['city'],
                     link: data['link'])
      redirect_back fallback_location: root_path, notice: 'Group was successfully updated'
    else
      redirect_back fallback_location: root_path, alert: 'Failed to update group'
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :urlname, :description, :location, :link)
    end

    def generate_events(urlname)
      @events = MeetupService.events(urlname)
      if @events
        @events.each do |event|
          new_event = Event.new
          new_event.group_id = @group.id
          new_event.meetup_id = event['id']
          new_event.name = event['name']
          new_event.date = Time.at(event['time']/1000).to_datetime
          new_event.description = event['description']
          new_event.last_updated = Time.at(event['updated']/1000).to_datetime
          unless new_event.save
            raise "couldn't create event"
          end
          if event['venue']
            create_venue(event['venue'], new_event.id)
          end
        end
      else
        raise 'no events found'
      end
    end

    def create_venue(venue_details, event_id)
      new_venue = Venue.new
      new_venue.event_id = event_id
      new_venue.name = venue_details['name']
      new_venue.lat = venue_details['lat']
      new_venue.lon = venue_details['lon']
      new_venue.address = venue_details['address_1']
      new_venue.city = venue_details['city']
      unless new_venue.save
        raise "couldn't create venue"
      end
    end
end
