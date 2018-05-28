class FilesController < ApplicationController

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