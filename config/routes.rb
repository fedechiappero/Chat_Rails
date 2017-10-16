Rails.application.routes.draw do
  devise_for :users

  resources :chat_rooms, only: [:new, :create, :show, :index, :update, :edit, :destroy]

  resources :users, only: [:index]

  resources :participants, only: [:create, :destroy]

  resources :charts, only: [:index]

  resources :charts, only: [] do
    collection do
      get 'users_by_chat'
      get 'popular_users'
      get 'current_day_messages'
    end
  end

  #post 'participants' => 'participants#create', as: :create_participant

  mount ActionCable.server => '/cable'

  root 'chat_rooms#index'
end
