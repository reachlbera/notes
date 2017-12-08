class FilesController < ApplicationController

  def index
    p "index"
    @importation =File::Log.all
  end

  def new
    
  end
  def create
    p "create"
    temp = params[:file_log][:avatar]
    data = {
      :file => temp.tempfile
      :filename =>temp.content_type
      :disk_filename =>temp.tempfile
      :container_type =>temp.content_type
    }
    @importation = File::Log.new(:file => file, :container_type=>params[:file_log][:avatar].content_type)
    @importation.save
    # p file = params[:file_log][:avatar]
    # p file.original_filename
    # p file.content_type
    # p file.headers
    # p file.filename
    # p file.voc_importation
    respond_to do |format|
      format.html {redirect_to "index"}
      format.json {}
    end
  end

	def get
    if params[:id]
    	p "files+++++++++++++++++++++++"
      @attachment = File::Picture.find(params[:id]) rescue nil
    else
      @attachment = File::Picture.where(:container_type=>params[:container], :ori_type=>params[:ori_type], :ii=>params[:ori_id], :filename=>params[:filename]).last
    end
    if @attachment&&File.exist?(@attachment.diskfile)
       send_file @attachment.diskfile, :filename => @attachment.filename,
                                      :type => @attachment.content_type,
                                      :disposition => (@attachment.content_type.to_s=~/image/ ? 'inline' : 'attachment')
    end
	end

  def download
    if params[:id]
      @attachment = File::Picture.find(params[:id]) rescue nil
    end
    if @attachment&&File.exist?(@attachment.diskfile)
       send_file @attachment.diskfile, :filename => @attachment.filename,
                                      :type => @attachment.content_type,
                                      :disposition =>'attachment'
    end
  end
  
end