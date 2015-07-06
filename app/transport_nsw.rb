require 'httparty'

class TransportNsw
  include HTTParty
  base_uri 'www.transportnsw.info'
  # debug_output $stderr
  headers 'referer' => 'http://www.transportnsw.info/en/maps-and-timetables/index.page?#ferry-status-updates-item-tab'

  def initialize
  end

  def timetable(route, date)
    fail ArgumentError unless ROUTES.has_key?(route)
    fail ArgumentError unless date =~ /\d\d\d\d\-\d\d\-\d\d/
    options = { query: ROUTES[route].merge({ date: date }) }
    self.class.get('/en/maps-and-timetables/timetables-result.page', options)
  end

  ROUTES = {
    'To Manly:Slow Ferry' => #Circular Quay to Manly'
      {
        "routeNum"=>"F1 Manly",
        "wca"=>"false",
        "mode"=>"ferry",
        "direction"=>"outbound",
        "type"=>"normal",
        "directionName"=>"(090F1)",
        "operator"=>"112",
        "motDesc"=>"Sydney Ferries Network",
        "count"=>"2"
      },
    'To Manly:Manly Fast Ferry' =>  #Circular Quay to Manly (Manly Fast Ferry)'
      {
        "routeNum"=>"Manly Fast Ferry",
        "wca"=>"false",
        "mode"=>"ferry",
        "direction"=>"outbound",
        "type"=>"normal",
        "directionName"=>"(55MFF)",
        "operator"=>"306",
        "motDesc"=>"Private ferry and fast ferry services",
        "count"=>"2"
      },
    'From Manly:Slow Ferry' => #Manly to Circular Quay'
      {
        "routeNum"=>"F1 Manly",
        "wca"=>"false",
        "mode"=>"ferry",
        "direction"=>"inbound",
        "type"=>"normal",
        "directionName"=>"(090F1)",
        "operator"=>"112",
        "motDesc"=>"Sydney Ferries Network",
        "count"=>"2"
      },
    'From Manly:Manly Fast Ferry' =>  #Manly to Circular Quay (Manly Fast Ferry)'
      {
        "routeNum"=>"Manly Fast Ferry",
        "wca"=>"false",
        "mode"=>"ferry",
        "direction"=>"inbound",
        "type"=>"normal",
        "directionName"=>"(55MFF)",
        "operator"=>"306",
        "motDesc"=>"Private ferry and fast ferry services",
        "count"=>"2"
      }
    }
end

=begin

# see route codes by clicking on show timetable for route at
# http://www.transportnsw.info/en/maps-and-timetables/index.page?#ferry-status-updates-item-tab
# and getting line url param

require 'addressable/uri'
require 'pp'
url = 'http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page?routeNum=Manly%20Fast%20Ferry&wca=false&mode=ferry&date=2015-07-06&direction=inbound&type=normal&directionName=(55MFF)&operator=306&motDesc=Private%20ferry%20and%20fast%20ferry%20services&count=2'
uri = Addressable::URI.parse(url)
keep = uri.query_values
keep.delete('date')
pp keep
=end
