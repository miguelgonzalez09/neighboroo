Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  put 'booking/:id/', to: 'bookings#update', as: 'update_booking'
  resources :items
  resources :bookings, only: [:index, :create, :destroy]
end
