require 'rubygems'
require 'json'
load 'cacher.rb'

def extract_departure_times(page)
  page.search("//table[@summary='Search Results Details']/tbody/tr[1]/td[@headers='headRoute1 headStop6_1']").map{ |node|
    t = node.inner_html
    if t =~ /(\d+):(\d+)(am|pm)/
      hours = $1.to_i
      mins = $2.to_i
      ampm = $3
      hours += 12 if ((ampm == 'pm' && hours != 12) || (ampm == 'am' && hours == 12))
      "#{sprintf('%02d', hours);}:#{sprintf("%.2d",mins)}"
    else
      print "Unrecognised time #{t} on #{page.title}\n"
    end
  }
end

def get_departure_times(route_code, date)
  url = "http://www.131500.com.au/plan-your-trip/timetables/@@details?line=#{route_code}&itd_itdDate=#{date}"
  # http://www.131500.com.au/plan-your-trip/timetables/@@details?line=NSW:09MAN:L:H:SJ2&itd_itdDate=20131225
  page = getPage(url)
  extract_departure_times(page)
end

def download_timetables(local_file)
  routes = {}
  routes['NSW:09MAN:L:H:SJ2'] = 'To Manly:Slow Ferry' #Circular Quay to Manly'
  routes['NSW:55001:_:H:SJ2'] = 'To Manly:Manly Fast Ferry' #Circular Quay to Manly (Manly Fast Ferry)'
  routes['NSW:56001:_:H:SJ2'] = 'To Manly:Sydney Fast Ferries' #Circular Quay to Manly (Sydney Fast Ferry)'
  routes['NSW:09MAN:L:R:SJ2'] = 'From Manly:Slow Ferry' #Manly to Circular Quay'
  routes['NSW:55001:_:R:SJ2'] = 'From Manly:Manly Fast Ferry' #Manly to Circular Quay (Manly Fast Ferry)'
  routes['NSW:56001:_:R:SJ2'] = 'From Manly:Sydney Fast Ferries' #Manly to Circular Quay (Sydney Fast Ferry)'

  dates = {} # some typical non public holiday dates, must be future dated and < 90 days
  dates['mon'] = '20130729'
  dates['tue'] = '20130730'
  dates['wed'] = '20130731'
  dates['thu'] = '20130801'
  dates['fri'] = '20130802'
  dates['sat'] = '20130803'
  dates['sun'] = '20130804'
  dates['hol'] = '20131007'

  departure_times = {}

  dates.each{ |day_of_week, date|
    departure_times[day_of_week] = {}
    routes.each{ |route_code, route_name|
      times = get_departure_times(route_code, date)
      departure_times[day_of_week][route_name] = times
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

p departure_times
=begin
http://www.manlyfastferry.com.au/media/manly_circularquay_services_20120917.jpg
http://www.sydneyfastferries.com.au/about-us.html
=end