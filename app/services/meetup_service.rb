class MeetupService
  include HTTParty

  @api_key = Rails.application.credentials.meetup_api_key
  base_uri 'api.meetup.com'

  attr_reader :options

  class << self
    def events(urlname)
      options = {
        query: {
          key: @api_key,
          no_earlier_than: Time.now.utc.iso8601.chop,
          page: 20
        }
      }
      data = get("/#{urlname}/events", options)
      if data.code.to_i == 200
        data.parsed_response
      else
        raise "Error fetching data from Meetup API"
      end
    end

    def event(urlname, meetup_id)
      data = get("/#{urlname}/events/#{meetup_id}")
      if data.code.to_i == 200
        data.parsed_response
      else
        raise "Error fetching data from Meetup API"
      end
    end

    def groups(search_text, location)
      options = {
        query: {
          key: @api_key,
          text: search_text,
          country: 'AU',
          location: location,
          page: 5
        }
      }
      data = get("/find/groups", options)
      if data.code.to_i == 200
        data.parsed_response
      else
        raise "Error fetching data from Meetup API"
      end
    end

    def group(urlname)
      data = get("/#{urlname}")
      if data.code.to_i == 200
        data.parsed_response
      else
        raise "Error fetching data from Meetup API"
      end
    end
  end
end
