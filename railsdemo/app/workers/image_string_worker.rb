class ImageStringWorker
  include Sidekiq::Worker

  def perform(html,zoom)
    Image.save_image_from_string(html,zoom)
  end
end
