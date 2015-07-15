require 'open-uri'
require 'nokogiri'

home = "http://www.mp4ba.com/"
content = "box clear"
encoding = "utf-8"

doc = Nokogiri::HTML.parse(open(home).read,nil,encoding)
dom = doc.css(".box .clear").first
trs = dom.css("tbody > tr")

trs.each{ |tr|
	tds = tr.css("td")
	time = Time.parse(tds[0].content)
	category = tds[1].content	
	title = tds[2].content
	url = tds[2].css("a").first
	title = url.content.strip!
	bt_url = "#{home}#{url.get_attribute('href')}"
	#puts "#{time}/#{category}/#{title}/#{bt_url}"
	movie_doc = Nokogiri::HTML.parse(open(bt_url,:read_timeout => 10).read,nil,encoding)
	original = movie_doc.css("#download").first
	download_url = "#{home}#{original.get_attribute('href')}"
	tmp_file_name = "#{Rails.root.to_s}/tmp/#{title}.torrent"
	puts "正在下载------>#{title}"
	open(tmp_file_name,"wb") do |file|
		file.print open(download_url).read
		file.close
	end
}