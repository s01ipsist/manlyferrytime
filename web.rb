require 'sinatra'

CACHE_TIME = 60 * 60 * 24 * 7

get '/' do
  expires CACHE_TIME, :public
  send_file File.expand_path('index.html', settings.public_folder)
end

set :static_cache_control, [:public, :max_age => CACHE_TIME]