require_relative './transport_nsw'
require_relative './timetable_parser'

class RemoteTimetable
  def initialize(date)
    @date = date
  end

  def departure_times
    transport_nsw = TransportNsw.new
    departure_times = {}
    TransportNsw::ROUTES.keys.each do |route|
      response = transport_nsw.timetable(route, @date)
      route_times = TimetableParser.new(response.body).parse
      departure_times[route] = route_times
    end
    departure_times
  end
end
