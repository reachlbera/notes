#encoding: utf-8
class Note::JournalsController < ApplicationController
	# before_action :authenticate_user!, only: [:index,:edit,:show,:create,:update]
	before_action :get_journal, only: [:show,:edit]
	# layout "journal"

	def index
		p "sdf"
	end

	def new
		@journal = Note::Journal.new
	end

	def edit
	end

	def show
	end

	def create
		p params
		params.permit! 
		@journal = Note::Journal.new(params[:note_journal])
		if @journal.save
			redirect_to note_journals_path,:notice => '保存成功.'
		else
			redirect_to note_journals_path,:notice => '保存失败.'
		end

	end

	def update
		p params
	end

	def get_journals
		@journals = Note::Journal.all
		render json:@journals
	end

	def image
		p params
		file = params[:image]
		p file
	end

	private
		def get_journal
			@journal = Note::Journal.find(params[:id])
		end

end