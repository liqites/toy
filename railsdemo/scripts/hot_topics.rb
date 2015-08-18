require 'nokogiri'
require 'capybara'
require 'capybara-webkit'

url = "http://d.weibo.com/100803?refer=index_hot_new"
browser = Capybara.current_session
browser.driver.headers = {'User-Agent' => 'spider'}
p browser.driver.headers
browser.visit url
browser.find("ul.pt_ul").all("li").each do |li|
	info_box = li.find('.info_box')
	p info_box
end