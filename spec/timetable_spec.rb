require 'spec_helper'
require_relative '../app/timetable'

describe Timetable do
  let(:timetable) { Timetable.new(html) }

  describe '#parse' do
    context 'manly slow ferry' do
      let(:html) { File.read 'spec/data/circular_quay_to_manly.html' }
      it 'parses correctly' do
        expect(timetable.parse).to eq ["05:30", "06:20", "06:50", "07:15", "07:40", "08:10", "08:40", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "18:50", "19:25", "19:55", "20:45", "21:30", "22:15", "23:00", "23:45"]
      end
    end

    context 'manly fast ferry to circular quay with multiple destination stops' do
      let(:html) { File.read 'spec/data/manly_fast_ferry_manly_to_circular_quay.html' }
      it 'parses correctly' do
        expect(timetable.parse).to eq ["06:15", "06:55", "07:15", "07:45", "08:05", "08:35", "08:55", "09:20", "09:50", "10:40", "11:40", "12:40", "13:40", "14:40", "15:45", "16:40", "17:10", "17:35", "18:05", "18:30", "19:00", "19:30", "19:50"]
      end
    end
  end
end

# curl "http://www.transportnsw.info/en/maps-and-timetables/timetables-result.page?routeNum=Manly%20Fast%20Ferry&wca=false&mode=ferry&direction=outbound&type=reverse&directionName=(55MFF)&operator=306&motDesc=Private%20ferry%20services&count=2&date=2014-03-18" >spec/data/manly_fast_ferry_manly_to_circular_quay.html
