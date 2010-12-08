class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #为应用程序中所有controller的action添加如下filter。
  #before_filter :set_charset
  
  #设置字符集
  #def set_charset
  #  @headers["Content-Type"] = "text/html; charset=utf8"
  #  @response.headers["Content-Type"] = "text/html; charset=utf8"
  #  suppress(ActiveRecord::StatementInvalid) do
  #    ActiveRecord::Base.connection.execute 'SET NAMES utf8'
  #  end
  #end
end
