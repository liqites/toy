class ImageTestWorker
  include Sidekiq::Worker

  sidekiq_options :retry => false

  def perform(html,zoom)
    f = Image.save_html(html)
    Image.save_image(f,zoom)
  end
end
