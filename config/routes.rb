Rails.application.routes.draw do
  resources :bugs do 
    collection do 
      post 'search', to: 'bugs#search'
    end
  end
  root to: 'bugs#index'

  resources :categories
end
