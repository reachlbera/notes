Rails.application.routes.draw do
  devise_for :users, class_name: "User", :controllers => { :sessions => "user/sessions",:registrations =>"user/registrations"}
  # devise_for :users do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#welcome"
  # root :to => "home#index"
  resources :home do 
  	collection do
  		get :welcome
  	end
  end
  resources :users do 
    collection do
    end
  end

  resources :study do 
    collection do
      get :vue
      get :api
    end
  end  

  namespace :note do 
    resources :journals do 
      collection do
        get :document
        get :get_journals
        get :image
        post :image
      end
    end
  end

  resources :files, :only=>[] do
    collection do
      get 'get_container_file_names'
      get 'get'
      get 'download'
      post 'upload'
      post 'delete'
    end
  end

end
