require 'readability'
require 'open-uri'

html = 'http://www.engadget.com/2015/06/15/iran-bans-officials-from-using-smartphones/?utm_source=Feed_Classic_Full&utm_medium=feed&utm_campaign=Engadget&?ncid=rss_full'

source = open(html).read
puts Readability::Document.new(source).content.green
puts Readability::Document.new(source).title.red