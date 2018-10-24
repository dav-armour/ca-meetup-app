class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # @events = [{name: "test1", start_time: Date.parse('2018-10-20')},
    #            {name: "test2", start_time: Date.parse('2018-10-22')},
    #            {name: "test3", start_time: Date.parse('2018-10-25')},
    #            {name: "test4", start_time: Date.parse('2018-10-2')}]
    @events = Event.all
    @next_event = @events.last
    @last_event = @events.first
    @ratings = { food: 1, drinks: 2, talks: 3, vibe: 4 }
  end
end
