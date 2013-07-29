require 'rubygems'
require 'json'
load 'cacher.rb'

def download_holidays(local_file)
  url = 'http://www.industrialrelations.nsw.gov.au/oirwww/NSW_public_holidays/NSW_Public_Holidays_2013-2015.page'
  page = getPage(url)

  headers = []
  holidays = {}
  page.search("//table/tbody/tr").each_with_index{ |row, i|
    cells = row.search('td')
    if i == 0 #cells[0].inner_text == ''
      headers << 'Holiday Name'
      i = 1
      while i < cells.size do
        year = cells[i].inner_text.strip
        holidays[year] = {}
        headers << year
        i += 1
      end
    else
      holiday_name = cells[0].inner_text.strip.gsub(/(\u00A0)+/,' ').gsub(/[^\w\s]/, '').gsub(' public holiday', '')
      i = 1
      while i < cells.size do
        year = headers[i]
        date = cells[i].inner_text.strip
        # holidays[holiday_name][year] = date
        if date =~ /.*, (.*)/
          d = Date.parse("#{$1} #{year}")
          month = d.strftime('%-m')
          day = d.strftime('%e')
          holidays[year][month] ||= Hash.new
          holidays[year][month][day] = holiday_name
        end
        i += 1
      end
    end
  }
  holidays.to_json

  File.open(local_file, 'w'){|f|
    f.print holidays.to_json
  }

  holidays
end

def read_holidays(local_file)
   JSON.parse(File.read(local_file))
end

local_file = 'public_holidays.json'
holidays = File.exists?(local_file) ? read_holidays(local_file) : download_holidays(local_file)

p holidays
