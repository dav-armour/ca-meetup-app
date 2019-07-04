class PagesController < ApplicationController
  def home
    # @events = [{name: "test1", start_time: Date.parse('2018-10-20')},
    #            {name: "test2", start_time: Date.parse('2018-10-22')},
    #            {name: "test3", start_time: Date.parse('2018-10-25')},
    #            {name: "test4", start_time: Date.parse('2018-10-2')}]

    @events = Event.all
    # @next_event = @events.last
    @next_event = current_user.events.where("date >= ?", Date.today).order('date ASC').first
    @last_event = current_user.events.where("date <= ?", Date.today).order('date DESC').first
    if @last_event
      found_rating = Rating.find_by(user_id: current_user.id, event_id: @last_event.id)
    end
    if found_rating
      @ratings = found_rating.to_hash
    else
      @ratings = { food: 0, drinks: 0, talks: 0, vibe: 0 }
    end
  end
end
