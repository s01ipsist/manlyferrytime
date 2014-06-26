heroku run console --app manlyferrytime


require 'dalli'
require 'memcachier'
dc = Dalli::Client.new
dc.set('memcachier', 'rocks')
dc.get('memcachier')
dc.stats

dc.get('2014-03-18')
dc.delete('2014-03-18')

heroku logs


Run locally with

foreman start

http://0.0.0.0:5000/