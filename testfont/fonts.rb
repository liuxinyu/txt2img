

#input_str = "这是一个短句\n这是一个长句1好好学习，天天向上。bu2好好学习，\
#天天向上。3好好学习，天天向上。4好好学习，天天向上。5好好学习，天天向上。6\
#好好学习，天天向上。7好好学习，天天向上。8好好学习，天天向上。\n这是一个短句\n短句"

input_arr = ['微软雅黑','方正稚艺','方正少儿','楷体','方正硬笔行书',\
  '方正硬笔楷书','方正小篆体','方正瘦金书','方正行黑']
font_arr = ["ms_yahei.ttf","fz_zhiyi.ttf","fz_shaoer.ttf","kaiti.ttf","fz_yingbixingshu.ttf",\
  "fz_yingbikaishu.ttf","fz_xiaozhuan.ttf","fz_soujin.ttf","fz_xinghei.ttf"] 

require 'rubygems'
require 'RMagick'


font_path = 'D:\\fonts\\'

for i in (0..8) do
  img = Magick::Image.read('bg4font.png').first    #图片路径
  gc= Magick::Draw.new
  gc.annotate(img, 0, 0, 8, 20, input_arr[i]) do  #可以设置文字的位置，参数分别为路径、宽度、高度、横坐标、纵坐标
    self.font = font_path+font_arr[i]
    self.pointsize = 22                         #字体的大小
    self.fill = '#000'                         #字体的颜色
    self.stroke = "none"
  end          
  img.write("outputs\\fontimg_" + File.basename(font_arr[i], 'ttf') + "png")  
end

=begin
imagename='ft_1.png'
img = Magick::Image.new(160,40,Magick::HatchFill.new('green','green')) 
gc= Magick::Draw.new
gc.stroke('transparent') 
gc.pointsize(20)
gc.font=font_path+'ms_yahei.ttf'
gc.text(8,20,'方正少儿简体')
gc.draw(img)
img.write(imagename)
=end




