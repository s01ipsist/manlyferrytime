require 'nokogiri'

class TimetableParser
  def initialize(html)
    @html = html
  end

  def parse
    page = Nokogiri::HTML(@html)
    page.css('table tbody tr.stop-major-odd:first-child td').map{ |node|
      t = node.inner_html
      t if t =~ /(\d+):(\d+)/
    }
  end
end