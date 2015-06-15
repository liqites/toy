require 'readability'
require 'open-uri'
include ActionView::Helpers

html = 'http://www.engadget.com/2015/06/15/iran-bans-officials-from-using-smartphones/?utm_source=Feed_Classic_Full&utm_medium=feed&utm_campaign=Engadget&?ncid=rss_full'

# get content from url
source = open(html).read
puts Readability::Document.new(source).content.red

# remove html tags from content
striped_content = strip_tags(Readability::Document.new(source).content)
puts striped_content.green