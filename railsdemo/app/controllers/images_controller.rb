class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @another_content = "Another Content"
    @images = Image.all
    respond_with(@images)
  end

  def show
    respond_with(@image)
  end

  def new
    @image = Image.new
    respond_with(@image)
  end

  def edit
  end

  def create
    @image = Image.new(image_params)
    @image.save
    respond_with(@image)
  end

  def update
    @image.update(image_params)
    respond_with(@image)
  end

  def destroy
    @image.destroy
    respond_with(@image)
  end

  def tohtml
    content= params[:content]
    #html = render_to_string("images/index.html.erb",locals: {:@another_content=> "Another Content"})
    # html = render_to_string("images/templates/a.html.erb")
    #f = Image.save_html(html)
    Image.save_image("http://localhost:8080/index.html")
    # puts "-------------------- new file"
    # kit = IMGKit.new(html)
    # puts "-------------------- new IMGKit"
    # puts kit.command("tmp/#{Guid.new.hexdigest}.jpg").join(" ")
    # puts "-------------------- puts command"
    # img = kit.to_img(:jpg)
    # puts "-------------------- to image"
    # file = Tempfile.new(["#{Guid.new.hexdigest}","jpg"],"tmp/imgs",:encoding => 'ascii-8bit')
    # puts "-------------------- new temp file"
    # file.write(img)
    # puts "-------------------- file write img"
    # file.flush
    # puts "-------------------- file flush"

    # Image.save_image_from_string(html)
    # puts Image.save_image_from_string(html,0.25)
    # puts Image.save_image(File.new(f.path),0.25)
    # ImageTestWorker.perform_async(html,1)
    # kit = IMGKit.new(f)
    # begin
    #   kit.to_img(:jpg,"tmp/imgs/111.jpg")
    # rescue => e
    #   puts e.backtrace
    #   puts e.messages
    # end

    # ImageStringWorker.perform_async(html,1)
    # ImageStringWorker.perform_async(html,0.5)
    # ImageStringWorker.perform_async(html,0.2)
    #
    # ImageWorker.perform_async(f.path,1)
    # ImageWorker.perform_async(f.path,0.5)
    # ImageWorker.perform_async(f.path,0.1)
    #puts "---------------------------"

    # 可能正在同时写或者同时读取
    # 不确定了，在Rails Console中可以保存，但是到了controller中，却会卡出
    # 并且报错，no such file mtp/test.jpg

    render json: {:content => content}
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params[:image]
    end

    def html_template(*args)
    end
end
