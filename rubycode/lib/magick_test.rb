require 'RMagick'
require 'rvg/rvg'
require 'guid'
require 'cconfig'

class MagickTest
  include Magick

  APP_ROOT = "#{CConfig::APP_PATH}"
  IMG_PATH = "#{APP_ROOT}/data/ex/images"
  FONT_PATH = "#{APP_ROOT}/data/ex/font"
  TMP_PATH = "#{APP_ROOT}/tmp"
  FONT = "Tsentsiu"

  def self.d
    Magick::RVG.dpi = 90

    rvg = Magick::RVG.new(1600, 1142).viewbox(0, 0, 1600, 1142) do |canvas|
      canvas.background_image = Magick::Image.read("#{APP_ROOT}/data/tree.jpg").first
      canvas.desc = "Example text01 - 'Hello, out there' in blue"
      text_style = {
          font: "#{FONT_PATH}/tsentsiu-regular.ttc",
          #glyph_orientation_vertical: 0,
          font_family: FONT,
          font_size: 60,
          fill: 'gray',
          font_weight: 'normal',
          font_style: 'normal',
          #writing_mode: 'tb',
          baseline_shift: 'super'
      }
      canvas.text(300, 150, "拇指阅读，文字").
          styles(text_style)
      canvas.text(250, 220, "MZRead,Word").styles(text_style)
      #canvas.circle(5, 250, 150).styles(:fill=>'red')

      # Show outline of canvas using 'rect' element
      #canvas.rect(997, 297).styles(:fill=>'none', :stroke=>'blue')
    end

    rvg.draw.write(tmp_path("jpg", "竖排文字"))

  end

  def self.test
    canvas = ImageList.new("#{APP_ROOT}/data/tree.jpg")
    text = Magick::RVG::Text.new(0, 0, "拇指阅读")
    # text.font = "#{FONT_PATH}/tsentsiu-regular.ttc"
    # text.font_family = FONT
    # text.pointsize = 52
    # text.gravity = Magick::CenterGravity
    text.annotate(canvas, 0, 0, 2, 2, str) {
      self.fill = 'gray83'
    }
    text.annotate(canvas, 0, 0, -1.5, -1.5, str) {
      self.fill = 'gray40'
    }
    text.annotate(canvas, 0, 0, 0, 0, str) {
      self.fill = 'darkred'
    }
    canvas.write(tmp_path("gif", "rvg-text"))
  end

  def self.a
    canvas = Magick::ImageList.new
    canvas.new_image(250, 250, Magick::HatchFill.new('white', 'gray90'))

    circle = Magick::Draw.new
    circle.stroke('tomato')
    circle.fill_opacity(0)
    circle.stroke_opacity(0.75)
    circle.stroke_width(6)
    circle.stroke_linecap('round')
    circle.stroke_linejoin('round')
    circle.ellipse(canvas.rows/2, canvas.columns/2, 80, 80, 0, 315)
    circle.polyline(180, 70, 173, 78, 190, 78, 191, 62)
    circle.draw(canvas)
    canvas.write(tmp_path)
  end

  def self.b
    # Demonstrate the annotate method
    str = '拇指阅读'
    # granite = Magick::ImageList.new('granite:')
    # canvas = Magick::ImageList.new
    # canvas.new_image(300, 100, Magick::TextureFill.new(granite))
    canvas = ImageList.new("#{APP_ROOT}/data/tree.jpg")
    text = Magick::Draw.new
    text.font = "#{FONT_PATH}/tsentsiu-regular.ttc"
    text.font_family = FONT
    text.pointsize = 52
    text.gravity = Magick::CenterGravity
    text.annotate(canvas, 0, 0, 2, 2, str) {
      self.fill = 'gray83'
    }
    text.annotate(canvas, 0, 0, -1.5, -1.5, str) {
      self.fill = 'gray40'
    }
    text.annotate(canvas, 0, 0, 0, 0, str) {
      self.fill = 'darkred'
    }
    canvas.write(tmp_path("gif"))
  end

  def self.c
    text = Draw.new
    text.pointsize = 28
    text.font = "#{FONT_PATH}/tsentsiu-regular.ttc"
    text.font_family = FONT
    text.font_weight = BoldWeight
    text.font_style = ItalicStyle
    text.gravity = CenterGravity

# Let's make it interesting. Composite the
# rotated text over a gradient fill background.
    fill = GradientFill.new(100, 100, 100, 100, "yellow", "red")
    bg = Image.new(200, 200, fill)

# The "none" color is transparent.
    fg = Image.new(bg.columns, bg.rows) { self.background_color = "none" }

# Here's where we'll collect the individual frames.
    animation = ImageList.new

    0.step(345, 15) { |degrees|
      frame = fg.copy
      text.annotate(frame, 0, 0, 0, 0, "Rotating Text") {
        self.rotation = degrees
      }
      # Composite the text over the gradient filled background frame.
      animation << bg.composite(frame, CenterGravity, DisplaceCompositeOp)
    }

    animation.delay = 8

#animation.animate
    puts "...Writing rotating_text.gif"
    animation.write(tmp_path("gif", "rotating_text"))
  end

  private
  def self.tmp_path(ext = nil, name = nil)
    fext = ext.nil? ? "jpg" : ext
    name = name.nil? ? "#{Guid.new.hexdigest}" : name
    "#{TMP_PATH}/#{name}.#{fext}"
  end
end