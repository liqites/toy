require 'open-uri'
require 'nokogiri'

url = "http://www.mp4ba.com"
content = "box clear"
encoding = 'utf-8'
doc = Nokogiri::HTML.parse(open(url).read,nil,encoding)
doms = doc.css(".box .clear")
puts doms.first