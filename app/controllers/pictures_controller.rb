class PicturesController < ApplicationController
	before_filter :find_model
	layout "picture"
	
	def index
		@pictures = File::Picture.all
	end
	def new
		@picture = File::Picture.new
	end
	def edit
		@picture = File::Picture.new
	end
	def create
    p "________________create_____________________"
    file = params[:file]
    # @file_url=nil
    # file = params.permit(file)
    @file_url = File::Picture.save_file(file)
    # @file_url = File::Picture.save_file(file)
    # p @file_url
    respond_to do |format|
	   #  format.html { render action: 'new', notice: '导入数据完成.'}
	    # format.json { render json: @file_url}
			format.html { redirect_to action:'index',data:@file_url}
 		  format.json { render json: @file_url, status: :created }	   
    end		
	end
	def update
		
	end

	def upload_file_async
		p params
		respond_to do |format|
			format.html
			format.json {render json:{:label=>"yes"}}
		end
	end

	def destroy
		
	end

	def multi_delete
		
	end

	private
	def find_model
		@model = File::Picture.find(params[:id]) if params[:id]
	end
end