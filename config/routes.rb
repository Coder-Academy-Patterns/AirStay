Rails.application.routes.draw do
  resources :listings
  root 'home#index'
  get 'explore' => 'explore#index'

  devise_for :users
  resources :profiles, except: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
