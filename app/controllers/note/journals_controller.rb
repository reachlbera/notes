#encoding: utf-8
class Note::JournalsController < ApplicationController
	# before_action :authenticate_user!, only: [:index,:edit,:show,:create,:update]
	# before_action :get_user only: [:index,:edit,:show,:create,:update]
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
	end

	def update
	end

	private

end