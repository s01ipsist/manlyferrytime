require 'rubygems'
require 'mechanize' #http://mechanize.rubyforge.org/mechanize/

def cache_file_exists?(cacheFileName)
  return nil if cacheFileName.nil? || cacheFileName.empty?

  full_cached_file_path = "cache/#{cacheFileName}"
  return full_cached_file_path if File.exist?(full_cached_file_path)

  full_cached_file_path_gz = "#{full_cached_file_path}.gz"
  return full_cached_file_path_gz if File.exist?(full_cached_file_path_gz)

  return nil
end

def retrievePageFromCache(cacheFileName)
  begin
    if full_cached_file_path = cache_file_exists?(cacheFileName)
      if File.extname(full_cached_file_path) == '.gz'
        File.open(full_cached_file_path, "r") do |f|
          gz = Zlib::GzipReader.new(f)
          f = gz.read
          gz.close
          return Nokogiri::HTML(f) #Nokogiri::HTML::Document
        end
      else
        f = File.open(full_cached_file_path, "r")
        return Nokogiri::HTML(f) #Nokogiri::HTML::Document
      end
    end
  rescue => e
    print "Error retrieving from cache\n"
    print "#{e.class} #{e.message}\n"
    return nil #invalid compressed data -- crc error (Zlib::GzipFile::CRCError)
  end
end

def getPage(url)
  cacheFileName = clean_file_name(url)
  use_cache = nil
  if cache_file_exists?(cacheFileName)
    use_cache = true
  else
    use_cache = false
  end

  if use_cache
    page = retrievePageFromCache(cacheFileName)
  else
    page = retrieveUrlGet(url)
  end
end

def clean_file_name(what)
  what = what.delete(',:\/*?"<>|%#$+@.').squeeze(" ").strip.tr(" ","_")
  what = what.hash.to_s if what.length > 200 #windows file name length limits =~ 255
  what
end

def retrieveUrlGet(url)
  cacheFileName = clean_file_name(url)

  begin
    page = @agent.get(url)
    body = page.body

    if page.response['content-type'] == 'application/x-gzip'
      extension = '.gz'
      gzip_this = false
    else
      extension = nil
      gzip_this = true
    end

    # # works but is very very slow. turn on to overcome
    # # ArgumentError invalid byte sequence in UTF-8
    # @encoding_utf8 ||= Encoding.find("UTF-8")
    # body = body.encode('UTF-8', :invalid => :replace, :undef => :replace) unless body.encoding == @encoding_utf8

    if gzip_this
      extension = '.gz'
      File.open("cache/#{cacheFileName}#{extension}", 'w') do |f|
        gz = Zlib::GzipWriter.new(f)
        gz.write body
        gz.close
      end
    else
      File.open("cache/#{cacheFileName}#{extension}", 'w') do |f|
        f.print body
      end
    end

    doc = Nokogiri::HTML(body)
    return doc

  rescue => e
    print "#{e.class} #{e.message}\n"
  end
end

@agent = Mechanize.new { |agent|
  agent.user_agent_alias = 'Windows IE 7' #'Mac Safari' #Mechanize::AGENT_ALIASES
  agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
}
FileUtils.mkdir_p "cache"