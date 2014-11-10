Rails.application.routes.draw do
  resources :bugs do 
    collection do 
      post 'search', to: 'bugs#search'
    end
  end
  root to: 'pages#home'

  resources :categories
  resources :users

  get 'login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

end
