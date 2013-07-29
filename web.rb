require 'sinatra'

get '/' do
  expires 2592000, :public
  send_file File.expand_path('index.html', settings.public_folder)
end
