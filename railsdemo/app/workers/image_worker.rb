class ImageWorker
  include Sidekiq::Worker

  def perform(file_path,zoom = 1)
    file = File.new(file_path)
    puts '----------------'
    puts file.path
    Image.save_image(file,zoom)
  end
end
