Rails.application.routes.draw do
  devise_for :users

  resources :chat_rooms, only: [:new, :create, :show, :index, :update, :edit, :destroy]

  resources :users, only: [:index]

  resources :participants, only: [:destroy]

  mount ActionCable.server => '/cable'

  root 'chat_rooms#index'
end
