require 'rubygems'
require 'json'
require 'addressable/uri' #https://github.com/sporkmonger/addressable

load 'cacher.rb'

def extract_departure_times(page)
  # require 'byebug'; byebug
  page.search("//table[@class='table-stripes timetable-stops-table']/tbody[@class='stop-odd']/tr[1]/td").map{ |node|
    t = node.inner_html
    if t =~ /(\d+):(\d+)/
      t
    else
      print "Unrecognised time #{t} on #{page.title}\n"
    end
  }
end

def get_departure_times(params)
  url = "http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page"

  uri = Addressable::URI.parse(url)
  uri.query_values = params

  url = uri.to_s

  print "#{url}\n"
  page = getPage(url)
  extract_departure_times(page)
end

def download_timetables(local_file)
  # route code by clicking on show timetable for route at http://www.131500.com.au/plan-your-trip/timetables/ and getting line url param
  routes = {}
  routes['To Manly:Slow Ferry'] = #Circular Quay to Manly'
    {
      routeNum: 'F1 Manly',
      wca: 'false',
      mode: 'ferry',
      direction: 'inbound',
      type: 'reverse',
      directionName: '(090F1)',
      operator: '112',
      motDesc: 'Sydney ferries',
      count: '2',
    }
  routes['To Manly:Manly Fast Ferry'] =  #Circular Quay to Manly (Manly Fast Ferry)'
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
    }
  routes['To Manly:Sydney Fast Ferries'] =  #Circular Quay to Manly (Sydney Fast Ferry)'
    {
      routeNum: 'Sydney Fast Ferry',
      wca: 'false',
      mode: 'ferry',
      direction: 'reverse',
      type: 'normal',
      directionName: '(56SFF)',
      operator: '307',
      motDesc: 'Private ferry services',
      count: '2',
    }
  routes['From Manly:Slow Ferry'] = #Manly to Circular Quay'
    {
      routeNum: 'F1 Manly',
      wca: 'false',
      mode: 'ferry',
      direction: 'inbound',
      type: 'normal',
      directionName: '(090F1)',
      operator: '112',
      motDesc: 'Sydney ferries',
      count: '2',
    }
  routes['From Manly:Manly Fast Ferry'] =  #Manly to Circular Quay (Manly Fast Ferry)'
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
    }
  routes['From Manly:Sydney Fast Ferries'] =  #Manly to Circular Quay (Sydney Fast Ferry)'
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

  dates = {} # some typical non public holiday dates, must be future dated and < 90 days
  dates['mon'] = '2013-12-30'
  dates['tue'] = '2013-12-31'
  dates['wed'] = '2014-01-01'
  dates['thu'] = '2014-01-02'
  dates['fri'] = '2014-01-03'
  dates['sat'] = '2014-01-04'
  dates['sun'] = '2014-01-05'
  dates['hol'] = '2014-01-01'

  departure_times = {}

  dates.each{ |day_of_week, date|
    print "Downloading #{date}\n"
    departure_times[day_of_week] = {}
    routes.each{ |route_name, params|
      print "Route #{route_name}\n"

      params.merge!({date: date})
      times = get_departure_times(params)
      departure_times[day_of_week][route_name] = times
      print "#{times}\n\n"
    }
  }

  # add times after midnight to next days schedule as well so shows up on both days
  days_of_week = ['mon','tue','wed','thu','fri','sat','sun', 'mon']
  dates.each{ |day_of_week, date|
    next unless days_of_week.index(day_of_week) # e.g. 'hol'
    routes.each{ |route_name, params|
      times = departure_times[day_of_week][route_name]
      next_day_of_week = days_of_week[days_of_week.index(day_of_week) + 1]
      times.each{ |time|
        if time >= '24:00'
          tomorrows_time = time.gsub('24:', '00:')
          if departure_times[next_day_of_week][route_name].nil?
            require 'byebug'; byebug
          end
          departure_times[next_day_of_week][route_name] = [tomorrows_time] + departure_times[next_day_of_week][route_name]
        end
      }
    }
  }



  File.open(local_file, 'w'){|f|
    f.print departure_times.to_json
  }

  departure_times
end

def read_timetables(local_file)
   JSON.parse(File.read(local_file))
end

local_file = 'departure_times.json'
departure_times = download_timetables(local_file)

File.open('departure_times_pp.json', 'w'){|f|
  f.print JSON.pretty_generate(departure_times)
}

p departure_times
=begin
http://www.manlyfastferry.com.au/media/manly_circularquay_services_20120917.jpg
http://www.sydneyfastferries.com.au/about-us.html
=end