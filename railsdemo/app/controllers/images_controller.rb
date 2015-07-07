class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
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
    html = render_to_string("images/index.html.erb")
    f = Image.save_html(html)

    ImageStringWorker.perform_async(html,1)
    ImageStringWorker.perform_async(html,0.5)
    ImageStringWorker.perform_async(html,0.2)

    ImageWorker.perform_async(f.path,1)
    ImageWorker.perform_async(f.path,0.5)
    ImageWorker.perform_async(f.path,0.1)
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
