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
    size = 500
    content= params[:content]
    html = html_template
    jpg = IMGKit.new(html,
      width: size,
      height: size
      )
    jpg.to_file("tmp/test.jpg")
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
      html = File.open("app/views/images/index.html.erb").read
      template = ERB.new(html)
      template.result
    end
end
