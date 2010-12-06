
class HomeController < ApplicationController
  def index
    @imagename='pic3.gif'
     #img = Magick::Image.read('tmp.jpg').first
     
     # If you want to save this image use following
      #img.write("mythumbnail.gif")
     require 'RMagick'
     img = Magick::ImageList.new("clown.jpg")
     #img = Magick::Image.new(200,200,Magick::HatchFill.new('green','green')) 
     # otherwise send it to the browser as follows
     gc=Magick::Draw.new
    # gc.stroke('red') 
     gc.pointsize(28)
     #gc.font('simhei.ttf')
     gc.font='simkai.ttf'
     gc.text(20,40,'生活真美好，')
     #gc.font='simhei.ttf'
     #gc.text(20,80,'你我共珍惜！')
     #gc.font='STXINWEI.TTF'
     #gc.text(20,120,'你我共珍惜！')
     
     gc.draw(img)
     img.write("public/images/#@imagename")
    # send_data(img.to_blob, :disposition => 'inline',:type => 'image/jpg')
  end


end
