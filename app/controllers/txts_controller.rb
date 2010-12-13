class TxtsController < ApplicationController
      FONT_SIZE = 22
    WIDTH = 400
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
        
        #--- path and name
        font_path = 'D:\\fonts'
        images_path = "public/images"
        output_path = 'public/images/outputs'
        bg_image_path = images_path + "/"+ "background.png"

        require 'find'
        
        Find.find(font_path) do |f|
          img = Magick::Image.read(bg_image_path).first    #图片路径
          gc= Magick::Draw.new
          gc.annotate(img, 0, 0, 400, 50, d_str) do  #可以设置文字的位置，参数分别为路径、宽度、高度、横坐标、纵坐标
            #self.gravity = Magick::CenterGravity
            self.font = f
            self.pointsize = FONT_SIZE                 #字体的大小
            self.fill = '#000'                         #字体的颜色
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
