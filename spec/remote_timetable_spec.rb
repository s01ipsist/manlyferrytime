require 'spec_helper'
require_relative '../app/remote_timetable'

describe RemoteTimetable do
  let(:remote_timetable) { RemoteTimetable.new(date) }

  describe '#departure_times' do
    before do
      canned_response = File.new 'spec/data/to_manly_slow_ferry.txt'
      stub_request(:get, 'http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page?count=2&date=2014-03-18&direction=inbound&directionName=%28090F1%29&mode=ferry&motDesc=Sydney%20ferries&operator=112&routeNum=F1%20Manly&type=reverse&wca=false').to_return(canned_response)
      canned_response = File.new 'spec/data/to_manly_manly_fast_ferry.txt'
      stub_request(:get, 'http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page?count=2&date=2014-03-18&direction=outbound&directionName=%2855MFF%29&mode=ferry&motDesc=Private%20ferry%20services&operator=306&routeNum=Manly%20Fast%20Ferry&type=normal&wca=false').to_return(canned_response)
      canned_response = File.new 'spec/data/to_manly_sydney_fast_ferries.txt'
      stub_request(:get, 'http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page?count=2&date=2014-03-18&direction=outbound&directionName=%2856SFF%29&mode=ferry&motDesc=Private%20ferry%20services&operator=307&routeNum=Sydney%20Fast%20Ferry&type=normal&wca=false').to_return(canned_response)
      canned_response = File.new 'spec/data/from_manly_slow_ferry.txt'
      stub_request(:get, 'http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page?count=2&date=2014-03-18&direction=inbound&directionName=%28090F1%29&mode=ferry&motDesc=Sydney%20ferries&operator=112&routeNum=F1%20Manly&type=normal&wca=false').to_return(canned_response)
      canned_response = File.new 'spec/data/from_manly_manly_fast_ferry.txt'
      stub_request(:get, 'http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page?count=2&date=2014-03-18&direction=outbound&directionName=%2855MFF%29&mode=ferry&motDesc=Private%20ferry%20services&operator=306&routeNum=Manly%20Fast%20Ferry&type=reverse&wca=false').to_return(canned_response)
      canned_response = File.new 'spec/data/from_manly_sydney_fast_ferries.txt'
      stub_request(:get, 'http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page?count=2&date=2014-03-18&direction=inbound&directionName=%2856SFF%29&mode=ferry&motDesc=Private%20ferry%20services&operator=307&routeNum=Sydney%20Fast%20Ferry&type=normal&wca=false').to_return(canned_response)
    end

    context 'manly slow ferry' do
      let(:date) { '2014-03-18' }
      it 'downloads remote timetable correctly' do
        expect(remote_timetable.departure_times).to eq ({
          "To Manly:Slow Ferry" =>
            ["05:30", "06:20", "06:50", "07:15", "07:40", "08:10", "08:40", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "18:50", "19:25", "19:55", "20:45", "21:30", "22:15", "23:00", "23:45"],
          "To Manly:Manly Fast Ferry" =>
            ["06:45", "07:15", "07:40", "08:09", "08:30", "09:00", "09:20", "10:10", "11:10", "12:10", "13:10", "14:10", "15:10", "16:15", "16:45", "17:10", "17:40", "18:00", "18:30", "19:05", "19:30"],
          "To Manly:Sydney Fast Ferries" =>
            ["06:55", "07:25", "07:45", "08:20", "08:40", "09:05", "16:30", "17:00", "17:20", "17:50", "18:15", "18:40", "19:10", "19:40"],
          "From Manly:Slow Ferry" =>
            ["00:20", "06:10", "06:35", "07:00", "07:30", "08:00", "08:20", "08:50", "09:20", "09:45", "10:15", "10:45", "11:15", "11:45", "12:15", "12:45", "13:15", "13:45", "14:15", "14:45", "15:15", "15:45", "16:15", "16:45", "17:15", "17:45", "18:10", "18:45", "19:15", "19:30", "20:05", "20:45", "21:30", "22:15", "23:00", "23:40"],
          "From Manly:Manly Fast Ferry" =>
            ["06:15", "06:55", "07:15", "07:45", "08:05", "08:35", "08:55", "09:20", "09:50", "10:40", "11:40", "12:40", "13:40", "14:40", "15:45", "16:40", "17:10", "17:35", "18:05", "18:30", "19:00", "19:30", "19:50"],
          "From Manly:Sydney Fast Ferries" =>
            ["06:30", "07:00", "07:20", "07:55", "08:15", "08:40", "09:10", "09:30", "16:55", "17:25", "17:45", "18:15", "18:40", "19:15", "19:35", "20:05"]})
      end
    end

  end
end

=begin
console code to generate spec data
require 'addressable/uri' #https://github.com/sporkmonger/addressable
curl_statements = []
date = '2014-03-18'
TransportNsw::ROUTES.keys.each do |route|
  uri = Addressable::URI.parse('http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page')
  uri.query_values = TransportNsw::ROUTES[route].merge({ date: date })
  url = uri.to_s
  file = route.downcase.gsub(/[\:\s]/,'_')
  curl_statements << "curl -i \"#{url}\" >spec/data/#{file}.txt"
  print "canned_response = File.new 'spec/data/#{file}.txt'\n"
  print "stub_request(:get, '#{url}').to_return(canned_response)\n"
end;nil
curl_statements.each do |s|
  print "#{s}\n"
end;nil
=end