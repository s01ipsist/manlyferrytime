require 'spec_helper'
require_relative '../app/transport_nsw'

describe TransportNsw do
  let(:transport_nsw) { TransportNsw.new }
  let(:valid_date) { '2015-04-18' }
  let(:valid_route) { 'To Manly:Slow Ferry' }

  describe '#timetable', vcr: { record: :once } do
    context 'when invalid route' do
      it 'raises an error' do
        expect { transport_nsw.timetable('unknown_route', valid_date) }.to raise_error(ArgumentError)
      end
    end

    context 'when invalid date' do
      it 'raises an error' do
        expect { transport_nsw.timetable(valid_route, 'invalid_date') }.to raise_error(ArgumentError)
      end
    end

    context 'valid call' do
      let(:response) { transport_nsw.timetable(valid_route, valid_date) }
      it 'responds correctly' do
        expect(response.headers['date']).to eq 'Mon, 06 Apr 2015 04:53:44 GMT'
        expect(response.response.code).to eq '200'
      end
    end
  end
end
