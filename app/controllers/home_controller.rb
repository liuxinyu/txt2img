class HomeController < ApplicationController
  def index
    images_path = "public/images"
    file_name="txt2img.png"
    file_path = images_path + "/"+ file_name
    img = Magick::Image.new(400,200,Magick::HatchFill.new('transparent','transparent')) 
    #img.opacity = 100
    gc= Magick::Draw.new
    gc.stroke('transparent') 
    gc.pointsize(28)
    gc.font='maozedong.ttf'
    gc.text(20,100,"this is a sample 好好学习，天天向上。毛泽东")
    gc.draw(img)
    img.write(file_path)
    @path = file_name
  end
  def rmagick
    images_path = "public/images"
    file_name = "rmagick_generated_thumb.jpg"
    file_path = images_path + "/"+ file_name

    File.delete file_path if File.exists? file_path
    img = Magick::Image.read("lib/sample_images/magic.jpg").first
    thumb = img.scale(0.25)
    @path = file_name
    thumb.write file_path
  end
end
