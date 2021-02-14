Rails.application.routes.draw do
  devise_for :users
  get 'home/about', as: 'home_about'
  root 'home#index'
  resources :users
  resources :books
end

# devise_forを一番上にしてあげる