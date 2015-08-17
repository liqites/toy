require 'nokogiri'
require 'capybara'
require 'capybara-webkit'

# url = "http://d.weibo.com/100803?refer=index_hot_new"
path = File.absolute_path("js/a.html")
url = "file://#{path}"
p url
browser = Capybara::Session.new(:poltergeist)
p browser
browser.visit(url)
sleep(5);
p browser.source