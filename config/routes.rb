Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "your_items", to: "items#user_items"
  put 'booking/:id/', to: 'bookings#update', as: 'update_booking'
  resources :items
  resources :bookings, only: [:index, :create, :destroy] do
    resources :reviews, only: :create
  end
  resources :reviews, only: [:index, :destroy]
end

#devise_for :users, controllers: {
        #sessions: 'users/sessions'
  #}
