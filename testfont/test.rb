require 'rubygems'
require 'RMagick'
imagename='txt2img.png'
img = Magick::ImageList.new(imagename)
#img = Magick::Image.new(200,200,Magick::HatchFill.new('green','white')) 
gc= Magick::Draw.new
gc.pointsize(28)
gc.font='maozedong.ttf'
gc.text(20,20,'�ú�ѧϰ����������')
gc.draw(img)
img.write(imagename)