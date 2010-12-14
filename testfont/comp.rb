input_str = "测试你老化了没有？ 将手心朝下平放在桌面，然后五指张开，用另一手的指腹\
 将拇指及食指下交接部位的肌肤用力夹起五秒钟，然后放开，若是马上皮肤缩回，表示你的生理\
 年龄还很年轻"

FONT_SIZE = 25
WIDTH = 350  # 设置文字显示区域的宽度，用于计算每行字数
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
src_img.border!(10, 10, "#f0f0ff")
frame_img = Magick::Image.read('frame.png').first
frame_img.composite!(src_img, 0, 0, Magick::OverCompositeOp)

# put user's picture into background
dest_img = Magick::Image.read('true_background.png').first
dest_img.composite!(frame_img, 20, 20, Magick::OverCompositeOp)

gc= Magick::Draw.new
gc.annotate(dest_img, 0, 0, 420, 50, d_str) do  #参数:目标图像、宽度、高度、横坐标、纵坐标
  self.font = 'fz_zhiyi.ttf'
  self.pointsize = FONT_SIZE                         #字体的大小
  self.fill = '#fff'                         #字体的颜色
  self.stroke = "none"
end      
dest_img.write('card_final.png')
dest_img_thumb = dest_img.resize(100, 50) 
dest_img_thumb.write('card_final_thumb.png')
