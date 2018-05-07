Rails.application.routes.draw do
  devise_for :users#, :skip => [:sessions], class_name: "User", :controllers => { :sessions => "devise/sessions",:registrations =>"devise/registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "home#welcome"
  root :to => "home#index"
  resources :home do 
  	collection do
  		get :welcome
  	end
  end


# devise_for :users, :skip => [:sessions]
  # as :user do
  # get 'account/login' => 'account#login', :as => :new_user_session
  # post 'account/login' => 'account#login_user', :as => :user_session
  # delete 'account/logout' => 'account#logout', :as => :destroy_user_session
# end

  # devise_for :users, class_name: "Admin::User", :controllers => { :sessions => "devise/sessions",:registrations =>"devise/registrations"}
  # devise_scope :user do
     # get '/users/sign_in' => 'devise/sessions#new', as: :new_user_session
     # post   '/users/sign_in'  => 'devise/sessions#create',  as: :user_session
     # delete '/users/sign_out' => 'devise/sessions#destroy', as: :destroy_user_session

     # post  '/users/password'  => 'devise/passwords#create', as: :user_password
     # put   '/users/password'  => 'devise/passwords#update', as: nil
     # patch '/users/password'  => 'devise/passwords#update', as: nil
  #    authenticated :user do
  #       root :to => 'home#welcome', as: :authenticated_root
  #    end
  #    unauthenticated :user do
  #       root :to => 'devise/sessions#new', as: :unauthenticated_root
  #    end

  # end
  
  # get "/admin/user/sessions/destroy"

end
