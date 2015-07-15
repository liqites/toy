require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'capybara'
require 'capybara-webkit'

url = "http://d.weibo.com/100803?cfs=&Pl_Discover_Pt6Rank__5_filter=hothtlist_type%3D0#_0"
Capybara::Webkit.configure do |c|
  c.allow_url("weibo.com")
end

Capybara.current_driver = :selenium
Capybara.run_server = false
browser = Capybara::Session.new(:selenium)
browser.visit(url)
sleep(3)
puts "1111111"
puts browser.find("div.WB_innerwrap").length#.find("div.m_wrap")
