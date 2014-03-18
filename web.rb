require 'sinatra'
require 'memcachier'
require 'dalli'
require 'json'

require_relative 'app/remote_timetable'

# MemCachier Setup
set :cache, Dalli::Client.new

get '/' do
  send_file File.expand_path('index.html', settings.public_folder)
end

get "/timetable/:date" do |date|
  @departure_times ||= settings.cache.fetch(date) do
    RemoteTimetable.new(date).departure_times.to_json
  end
end
