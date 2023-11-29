Rails.application.routes.draw do
  root "photos#index"
  devise_for :users
  resources :line_items
  resources :orders
  post 'orders/charge', to: 'orders#charge', as: :orders_charge
  resources :carts, only: [:show] do
    post 'add/:photo_id', to: 'carts#add', as: :add_to
    delete 'carts/remove/:line_item_id', to: 'carts#remove', as: :cart_remove_from
  end
  resources :photos
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
