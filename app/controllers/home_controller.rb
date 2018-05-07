#encoding: utf-8
class HomeController < ApplicationController
	before_action :authenticate_user!
	# before_filter :get_user
	def index
		p "index"
		p params
		@users = User.all
		# @messages = Test.all
	end

	def edit
		p "edit"
		p params
	end

	def show
		p "show"
		p params
		@user = User.find(params[:id])
	end

	def create
    p "_____________________________________"
    # p params
    # @file_url=nil
    # p file = params.permit(:upload_file)[:upload_file]
    # @file_url = File::Picture.save_file(file)
    # # @file_url = File::Picture.save_file(file)
    # p @file_url
    # respond_to do |format|
	   #  format.html { render action: 'test', notice: '导入数据完成.'}
	   #  format.json { render json: @file_url }
    # end
	end

	def update
		p "update"
		p params

    # Thread.new{
    # p	file = params.require(:home).permit(:avatar)[:avatar]
    	# @attachment = Voc::Attachment.new(:file => file, :container_type=>'Voc_Upload', :ori_type=>'avatar')
    	# @attachment.author = current_user
    	# @attachment.filename ||= params[:filename].presence || current_user.id.to_s+'_'+rand(99999999).to_s(36)
    	# @attachment.save

      # @importation = Voc::Importation.new(params.require(:voc_importation).permit(:option_replace_choice))

      # @importation.parse if @importation.verify(@attachment)
    # }
    
    # redirect_to home_url,:notice => '导入数据完成.'		
	end

  def upload
    # file,ori=nil,nil
    # params[params[:container]].each {|k,v| ori=k;file=v}
    # @attachment = File::Picture.new(:file => file, :container_type=>params[:container], :ori_type=>ori)
    # @attachment.author = current_user
    # @attachment.filename ||= params[:filename].presence || Time.new.strftime('%Y%m%d%H%M%S')+'_'+rand(99999999).to_s(36)
    # @attachment.save


  end

  def color
  	
  end
  
	def travel
		# p File.dirname(__FILE__)
		# p File.expand_path(File.dirname(__FILE__))
		# p File.expand_path(File.dirname(__FILE__) + '/../..')
		# p "___________++++++++++++++++__________________"
		# p File::Picture.new.transfer_channel("wer")
	end

	def welcome
		# @sale = File::Picture.all
	end

	def test
		@file_array = File::Picture.all
	end

	def hardware_info
		# filename="/proc/stat"
		# @info={}
		# str = ""
		# total_cpu_time=nil
		# unless File.exist?(filename)#条件不成立的时候执行
		#   p @info = "not find"
		# else
		#   # file=File.new(filename, "w")
		#   p "else"
		#   tmp = 1;
		#   File.open(filename,"r") do |file|
		#     while line = file.gets
		#     	case tmp
		#     	when 1
		#     		@info<<{total_time: line.split(" ").map { |e| b +=e.to_i;b }}
	 #    		when condition
		    			
		#     	end
		#     	str << line.to_s
		# 	  end
		#   end
		# end

		# @info = system 'echo "hello $HOSTNAME"'
		# if @info
		# 	render json:{info:@info}
		# else
		# 	render json:{info:"Nothing"}
		# end
	end

	def socket
		p params
		# document_id = params[:document_id]
		# AsyncBroadcastJob.perform_later document_id:document_id
	end
end