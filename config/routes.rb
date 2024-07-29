Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'homes/about', to: 'homes#about', as: 'about'

  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :show, :edit, :update, :create, :new, :destroy]
end
