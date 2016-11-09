Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  resources :profiles, except: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
