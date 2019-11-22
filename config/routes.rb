Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "your_items", to: "items#user_items"
  put 'booking/:id/', to: 'bookings#update', as: 'update_booking'
  resources :items do
    resources :messages, only: :create
  end
  resources :bookings, only: [:index, :create, :destroy]
  resources :messages, only: [:index, :destroy]
end

#devise_for :users, controllers: {
        #sessions: 'users/sessions'
  #}
