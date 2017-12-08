Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#welcome'
  resources :home do
  	collection do
  		get :bootstrap
      get :lowprice
      get :test
      get :rest
      get :travel
      get :welcome
      get :color
      get :socket
  	end
  end

  mount ActionCable.server => "/cable"
  
  resources :room do
  	collection do 
  		get :setup
  	end
  end

  resources :pictures do
    collection do
      post :upload_file_async
    end
  end

  resources :files do
    collection do
      get :get
      get :download
    end
  end

end
