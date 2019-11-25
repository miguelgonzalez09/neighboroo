Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "your_items", to: "items#user_items"
  get "request_item", to: "items#request_item"
  put 'booking/:id/', to: 'bookings#update', as: 'update_booking'

  resources :bookings, only: [:index, :create, :destroy] do
    resources :reviews, only: :create
  end

  resources :reviews, only: [:index, :destroy]
  resources :items do
    resources :messages, only: [:create]
  end
  resources :messages, only: [:index, :show, :destroy]

end

#devise_for :users, controllers: {
        #sessions: 'users/sessions'
  #}
