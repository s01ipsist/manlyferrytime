require 'sinatra'
require 'memcachier'
require 'dalli'

require_relative 'app/transport_nsw'
require_relative 'app/timetable'

# MemCachier Setup
set :cache, Dalli::Client.new

get '/' do
  send_file File.expand_path('index.html', settings.public_folder)
end

get "/timetable/:date" do |date|
  transport_nsw = TransportNsw.new
  departure_times = {}
  TransportNsw::ROUTES.keys.each do |route|
    response = transport_nsw.timetable(route, date)
    route_times = Timetable.new(response.body).parse
    departure_times[route] = route_times
  end
  departure_times.to_json
end

# /timetable/2014-03-18