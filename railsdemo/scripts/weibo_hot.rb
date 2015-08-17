require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'capybara'
require 'capybara-webkit'

url = "http://d.weibo.com/100803?refer=index_hot_new"
Capybara::Webkit.configure do |c|
  c.allow_url("weibo.com")
end

Capybara.current_driver = :selenium
Capybara.run_server = false
browser = Capybara::Session.new(:selenium)
browser.visit(url)
browser.find("#Pl_Discover_Pt6Rank__5").find(".m_wrap").find("ul").all("li").each do |li|
	info_box = li.find(".info_box")
	title = info_box.find(".title").all("a").first.text
	puts title
	sub_title = info_box.find(".subtitle").text
	puts sub_title
end