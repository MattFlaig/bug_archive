Rails.application.routes.draw do
  root to: 'pages#home'

  resources :bugs do 
    collection do 
      post 'search', to: 'bugs#search'
    end

    resources :solutions do
      resources :listings, only: [:new, :create]
      
    end

    member do 
      post :show_concept
    end

    resources :listings, only: [:new, :create]
     
  end

  resources :concepts, only: [:index, :new, :create]
  resources :categories
  resources :users

  get 'login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  

end
