require 'imgkit'
require 'cconfig'
require 'guid'

class OpenTest
  def self.gimage
    file = File.new("#{CConfig::APP_PATH}/data/index.html")
    kit = IMGKit.new(file)
    kit.to_file("#{CConfig::APP_PATH}/tmp/#{Guid.new.hexdigest}.jpg")
    # 10.times do |i|
    #   t = Thread.new do
    #     kit = IMGKit.new(file)
    #     kit.to_file("#{CConfig::APP_PATH}/tmp/#{i}_#{Guid.new.hexdigest}.jpg")
    #   end
    # end
  end
end
