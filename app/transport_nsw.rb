require 'httparty'

class TransportNsw
  include HTTParty
  base_uri 'www.transportnsw.info'
  # debug_output $stderr

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
        routeNum: 'F1 Manly',
        wca: 'false',
        mode: 'ferry',
        direction: 'inbound',
        type: 'reverse',
        directionName: '(090F1)',
        operator: '112',
        motDesc: 'Sydney Ferries Network',
        count: '2',
      },
    'To Manly:Manly Fast Ferry' =>  #Circular Quay to Manly (Manly Fast Ferry)'
      {
        routeNum: 'Manly Fast Ferry',
        wca: 'false',
        mode: 'ferry',
        direction: 'outbound',
        type: 'normal',
        directionName: '(55MFF)',
        operator: '306',
        motDesc: 'Private ferry services',
        count: '2',
      },
    'To Manly:Sydney Fast Ferries' =>  #Circular Quay to Manly (Sydney Fast Ferry)'
      {
        routeNum: 'Sydney Fast Ferry',
        wca: 'false',
        mode: 'ferry',
        direction: 'outbound',
        type: 'normal',
        directionName: '(56SFF)',
        operator: '307',
        motDesc: 'Private ferry services',
        count: '2',
      },
    'From Manly:Slow Ferry' => #Manly to Circular Quay'
      {
        routeNum: 'F1 Manly',
        wca: 'false',
        mode: 'ferry',
        direction: 'inbound',
        type: 'normal',
        directionName: '(090F1)',
        operator: '112',
        motDesc: 'Sydney Ferries Network',
        count: '2',
      },
    'From Manly:Manly Fast Ferry' =>  #Manly to Circular Quay (Manly Fast Ferry)'
      {
        routeNum: 'Manly Fast Ferry',
        wca: 'false',
        mode: 'ferry',
        direction: 'outbound',
        type: 'reverse',
        directionName: '(55MFF)',
        operator: '306',
        motDesc: 'Private ferry services',
        count: '2',
      },
    'From Manly:Sydney Fast Ferries' =>  #Manly to Circular Quay (Sydney Fast Ferry)'
      {
        routeNum: 'Sydney Fast Ferry',
        wca: 'false',
        mode: 'ferry',
        direction: 'inbound',
        type: 'normal',
        directionName: '(56SFF)',
        operator: '307',
        motDesc: 'Private ferry services',
        count: '2',
      }
    }
end

=begin

# see route codes by clicking on show timetable for route at
# http://www.transportnsw.info/en/maps-and-timetables/index.page?#ferry-status-updates-item-tab
# and getting line url param

require 'addressable/uri'
url = 'http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page?routeNum=F1%20Manly&wca=false&mode=ferry&date=2014-06-26&direction=inbound&type=normal&directionName=(090F1)&operator=112&motDesc=Sydney%20Ferries%20Network&count=2'
uri = Addressable::URI.parse(url)
uri.query_values
=end