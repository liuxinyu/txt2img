

input_str = "这是一个短句\n这是一个长句1好好学习，天天向上。bu2好好学习，\
天天向上。3好好学习，天天向上。4好好学习，天天向上。5好好学习，天天向上。6\
好好学习，天天向上。7好好学习，天天向上。8好好学习，天天向上。\n这是一个短句\n短句"

FONT_SIZE = 22
WIDTH = 400
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
=begin
imagename='txt2img.png'
img = Magick::Image.new(400,200,Magick::HatchFill.new('green','green')) 
gc= Magick::Draw.new
gc.stroke('transparent') 
gc.pointsize(FONT_SIZE)
gc.font='maozedong.ttf'
gc.text(20,20,d_str)
gc.draw(img)
img.write(imagename)
=end 
img = Magick::Image.read('background.png').first    #图片路径
gc= Magick::Draw.new
gc.annotate(img, 0, 0, 400, 50, d_str) do  #可以设置文字的位置，参数分别为路径、宽度、高度、横坐标、纵坐标
  self.font = 'maozedong.ttf'
  self.pointsize = FONT_SIZE                         #字体的大小
  self.fill = '#000'                         #字体的颜色
  self.stroke = "none"
end          
img.border!(18, 18, "#f0f0ff")  # border
img.write('txt2img.png')  






