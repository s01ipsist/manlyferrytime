require 'spec_helper'
require_relative '../app/transport_nsw'

describe TransportNsw do
  let(:transport_nsw) { TransportNsw.new }
  describe '#timetable' do
    before do
      canned_response = File.new 'spec/data/to_manly_slow_ferry.txt'
      stub_request(:get, 'http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page?routeNum=F1%20Manly&wca=false&mode=ferry&direction=inbound&type=reverse&directionName=(090F1)&operator=112&motDesc=Sydney%20ferries&count=2&date=2014-03-18').to_return(canned_response)
    end
    let(:response) { transport_nsw.timetable('To Manly:Slow Ferry', '2014-03-18') }
    it 'responds correctly' do
      expect(response.headers['date']).to eq 'Tue, 18 Mar 2014 03:32:06 GMT'
      expect(response.response.code).to eq '200'
    end
  end
end
