#encoding: utf-8
class StudyController < ApplicationController
	# before_action :authenticate_user!, only: [:index,:edit,:show,:create,:update]
	# before_action :get_user only: [:index,:edit,:show,:create,:update]
	# layout "home"
	# before_filter :get_user
	def index
	end

	def edit
	end

	def show
	end

	def create
	end

	def update
	end

	def vue
		
	end

	def api
		render json:{we:23}
	end
	private
		# def get_user
		# 	:authenticate_user!
		# end
end