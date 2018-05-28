class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_charsets
  
	def configure_charsets          
	  # @headers["Content-Type"]="text/html;charset=utf-8"      
	end      
	  
	def uploadFile(file)    
	  if !file.original_filename.empty?  
	    #生成一个随机的文件名      
	    @filename=getFileName(file.original_filename)         
	    #向dir目录写入文件  
	    File.open("#{RAILS_ROOT}/public/emag/upload/#{@filename}", "wb") do |f|   
	       f.write(file.read)  
	    end   
	    #返回文件名称，保存到数据库中  
	    return @filename  
	  end  
	end   

	def getFileName(filename)  
	  if !filename.nil?  
	    require 'uuidtools'  
	    filename.sub(/.*./,UUID.random_create.to_s+'.')  
	  end  
	end

end
