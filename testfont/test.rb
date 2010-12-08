=begin
  

require 'rubygems'
require 'RMagick'
imagename='txt2img.png'
img = Magick::Image.new(400,200,Magick::HatchFill.new('green','green')) 
gc= Magick::Draw.new
gc.stroke('transparent') 
gc.pointsize(28)
gc.font='maozedong.ttf'
gc.text(20,100,'haohao xue xi 好好学习，天天向上。毛泽东')
gc.draw(img)
img.write(imagename)

=end


str = 'lib/fonts/maozedong.ttf'
puts File.basename str
