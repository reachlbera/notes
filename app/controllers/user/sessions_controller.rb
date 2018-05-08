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
    current_user.del_permissions    #  redis 中删除 current_user_permissions
    # super
    sign_out(current_user)
    cmc_ip = User.ip("cmc")
    (redirect_to "/" and return) unless cmc_ip.present?
    sign_out_cmc = "http://" + cmc_ip.to_s + "/users/sign_out"
    redirect_to sign_out_cmc
  end
end
