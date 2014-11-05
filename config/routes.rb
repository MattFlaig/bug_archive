Rails.application.routes.draw do
  resources :bugs
  root to: 'bugs#index'

  resources :categories
end
