#encoding:utf-8
class User::SessionsController < Devise::SessionsController
  # layout 'login'

  def create
    p params
    auth_options = { :recall => 'home#index', :scope => :user }
    resource = warden.authenticate!(auth_options)
    super
    #resource.set_permissions
  end

  def destroy
    p params
    sign_out(current_user)
    redirect_to "/"
  end
end
