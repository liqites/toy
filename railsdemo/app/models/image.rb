
class Image < ActiveRecord::Base
  extend ActionController::Rendering

  ORIGINAL_HEIGHT= 1142
  ORIGINAL_WIDTH = 1600

  def self.save_html(html)
    f = File.new("tmp/#{Time.now.to_i}.html","w")
    File.open(f.path,"w") do |f|
      f.puts html
    end
    f
  end

  def self.save_image(file,zoom = 1)
    height = ORIGINAL_HEIGHT * zoom
    width = ORIGINAL_WIDTH * zoom
    kit = IMGKit.new(file, width: width.to_i, height: height.to_i,zoom: zoom, "window-status" => "IMAGE")
    g = Guid.new
    puts "-----------------------------"
    out_file_path = "tmp/imgs/#{Time.now.to_i}-#{g.hexdigest}-#{width}x#{height}.jpg"
    puts kit.command(out_file_path).join(" ")
    kit.to_file(out_file_path)
  end

  def self.save_image_from_string(html,zoom = 1)
    height = ORIGINAL_HEIGHT * zoom
    width = ORIGINAL_WIDTH * zoom
    kit = IMGKit.new(html, width: width.to_i, height: height.to_i,zoom: zoom,"window-status"=> "IMAGE")
    puts "-----------------------------"
    g = Guid.new
    out_file_path = "tmp/imgs/#{Time.now.to_i}-#{g.hexdigest}-#{width}x#{height}.jpg"
    puts kit.command(out_file_path).join(" ")
    kit.to_file(out_file_path)
  end

  def self.save_image_command(file,zoom = 1)
    height = ORIGINAL_HEIGHT * zoom
    width = ORIGINAL_WIDTH * zoom
    kit = IMGKit.new(file, width: width.to_i, height: height.to_i,zoom: zoom)
    g = Guid.new
    puts "-----------------------------"
    out_file_path = "tmp/imgs/#{Time.now.to_i}-#{g.hexdigest}-#{width}x#{height}.jpg"
    cmd = kit.command(out_file_path).join(" ")
    o,e,s = Open3.capture3(cmd)
    puts o
    puts e
    puts s
  end
end
