Rails.application.routes.draw do
  resources :charges, only: [:new, :create]
  resources :menus
  devise_for :users
  # devise_for :users
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
