class TxtsController < ApplicationController
    FONT_SIZE = 25  # 字体大小
    WIDTH = 350 # 设置文字显示区域的宽度，用于计算每行字数
    NUM_WORD_PER_LINE = (WIDTH/FONT_SIZE).round
    
  # GET /txts
  # GET /txts.xml
  def index
    @txts = Txt.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @txts }
    end
  end

  # GET /txts/1
  # GET /txts/1.xml
  def show
    @txt = Txt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @txt }
    end
  end

  # GET /txts/new
  # GET /txts/new.xml
  def new
    @txt = Txt.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @txt }
    end
  end

  # GET /txts/1/edit
  def edit
    @txt = Txt.find(params[:id])
  end

  # POST /txts
  # POST /txts.xml
  def create
    @txt = Txt.new(params[:txt])

        
    respond_to do |format|
      if @txt.save
        
        # long text parser        
        $KCODE='utf8'
        require 'jcode'
        d_str =''
        @txt.longtext.each {|s_str| 
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
        
        #--- path and name. to be config/updated in new environments
        font_path = 'D:\\fonts'
        images_path = "public/images"
        output_path = 'public/images/outputs'
        bg_image_path = images_path + "/"+ "background.png"

        require 'find'
        # do the same thing for each available fonts
        Find.find(font_path) do |f|
          img = Magick::Image.read(bg_image_path).first    #图片路径
          src_img = Magick::Image.read(images_path+'/user_image.JPG').first  # to be replaced with user's picture url
          src_img.crop_resized!(320,320)  # 照片的目标尺寸
          src_img.border!(10, 10, "#f0f0ff")    #相框的颜色，宽度
          frame_img = Magick::Image.read(images_path+'/frame.png').first    # picture frame
          frame_img.composite!(src_img, 0, 0, Magick::OverCompositeOp)
          img.composite!(frame_img, 20, 20, Magick::OverCompositeOp)
          
          gc= Magick::Draw.new
          gc.annotate(img, 0, 0, 420, 50, d_str) do  #可以设置文字的位置，参数分别为路径、宽度、高度、横坐标、纵坐标
            #self.gravity = Magick::CenterGravity
            self.font = f
            self.pointsize = FONT_SIZE                 #字体的大小
            self.fill = '#fff'                         #字体的颜色
            self.stroke = "none"
          end          
          font_file_name = File.basename(f, 'ttf')
          file_path = output_path + "/"+ @txt.image_url + "_" + font_file_name + "png"  
          img.write(file_path)  
        end
        
        #@path = file_name
        format.html { redirect_to(@txt, :notice => 'Txt was successfully created.') }
        format.xml  { render :xml => @txt, :status => :created, :location => @txt }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @txt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /txts/1
  # PUT /txts/1.xml
  def update
    @txt = Txt.find(params[:id])

    respond_to do |format|
      if @txt.update_attributes(params[:txt])
        format.html { redirect_to(@txt, :notice => 'Txt was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @txt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /txts/1
  # DELETE /txts/1.xml
  def destroy
    @txt = Txt.find(params[:id])
    @txt.destroy

    respond_to do |format|
      format.html { redirect_to(txts_url) }
      format.xml  { head :ok }
    end
  end
end
