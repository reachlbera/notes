class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	# Rails 4.x.x and newer
	before_action :configure_permitted_parameters, if: :devise_controller?

	def configure_permitted_parameters
	  # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
	  devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit({ roles: [] }, :login, :email, :password, :password_confirmation, :username) }
	end

end
