json.extract! meeting, :id, :name, :date, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
