input_str = "测试你老化了没有？ 将手心朝下平放在桌面，然后五指张开，用另一手的指腹\
 将拇指及食指下交接部位的肌肤用力夹起五秒钟，然后放开，若是马上皮肤缩回，表示你的生理\
 年龄还很年轻"

FONT_SIZE = 25
WIDTH = 350
NUM_WORD_PER_LINE = (WIDTH/FONT_SIZE).round
$KCODE='utf8'
require 'jcode'
d_str =''
input_str.each {|s_str| 
  while s_str.jsize > NUM_WORD_PER_LINE
    tmp_str = s_str.scan(/./)[0,NUM_WORD_PER_LINE].join
    d_str += tmp_str + "\n\n"
    s_str = s_str[tmp_str.size,s_str.size-tmp_str.size]
    if s_str == nil then break end
    #puts s_str.jsize  
  end
  if s_str!=nil then d_str += s_str end
  d_str += "\n"
}

require 'rubygems'
require 'RMagick'

src_img = Magick::Image.read('user_image.jpg').first
src_img.crop_resized!(320,320)
src_img.border!(10, 10, "#000") # ""#f0f0ff")

=begin
# Bend the image

src_img.background_color = "none"
amplitude = src_img.columns * 0.01        # vary according to taste
wavelength = src_img.rows  * 2
src_img.rotate!(90)
src_img = thumb_img.wave(amplitude, wavelength)
src_img.rotate!(-90)


#加上阴影的话，阴影外面还有个白边，现在还没能处理掉
# Make the shadow
shadow = src_img.flop
shadow = shadow.colorize(1, 1, 1, "gray75")     # shadow color can vary to taste
shadow.background_color = "white"       # was "none"
shadow.border!(8, 8, "white")
shadow = shadow.blur_image(0, 3)        # shadow blurriness can vary according to taste
# Composite image over shadow. The y-axis adjustment can vary according to taste.
src_img = shadow.composite(thumb_img, -amplitude/2, 5, Magick::OverCompositeOp)
#src_img.rotate!(-5)                       # vary according to taste
#src_img.trim!
src_img.write('user_image_thumb.png')
=end

# put user's picture into background
dest_img = Magick::Image.read('true_background.png').first
dest_img.composite!(src_img, 10, 8, Magick::OverCompositeOp)

gc= Magick::Draw.new
gc.annotate(dest_img, 0, 0, 420, 50, d_str) do  #可以设置文字的位置，参数分别为路径、宽度、高度、横坐标、纵坐标
  self.font = 'fz_zhiyi.ttf'
  self.pointsize = FONT_SIZE                         #字体的大小
  self.fill = '#fff'                         #字体的颜色
  self.stroke = "none"
end      
dest_img.write('card_final.png')
dest_img_thumb = dest_img.resize(100, 50) 
dest_img_thumb.write('card_final_thumb.png')
