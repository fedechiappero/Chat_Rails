Rails.application.routes.draw do
  devise_for :users

  resources :chat_rooms, only: [:new, :create, :show, :index, :update, :edit]

  resources :users, only: [:index]

  mount ActionCable.server => '/cable'

  root 'chat_rooms#index'
end
