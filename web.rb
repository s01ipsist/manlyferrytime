require 'sinatra'
require 'memcachier'
require 'dalli'
require 'json'

require_relative 'app/remote_timetable'

# MemCachier Setup
set :cache, Dalli::Client.new

helpers do
  def get_departure_times(date)
    @departure_times ||= settings.cache.fetch(date) do
      RemoteTimetable.new(date).departure_times
    end
  end
end

get '/' do
  send_file File.expand_path('index.html', settings.public_folder)
end

get "/timetable/:date.?:format?" do |date, format|
  @departure_times = get_departure_times(date)
  if format == 'json'
    @departure_times.to_json
  else
    erb :timetable
  end
end
