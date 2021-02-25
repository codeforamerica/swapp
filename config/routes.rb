Rails.application.routes.draw do
  get 'landing/index'
  devise_for :users, controllers: {
    sessions: 'sessions/sessions'
  }

  resources :clients
  resources :intakes
  resources :vouchers
  get "vouchers/:id/created" => "vouchers#created", as: :voucher_created
  resources :swaps

  # get "admin" => "admin/home#index"
  namespace :admin do
    get "/" => "home#index", as: :home
    put "swaps/:id/extend" => "swaps#extend", as: :extend_swap
    put "swaps/:id/room_supply" => "swaps#update_room_supply", as: :update_room_supply
  end
 
  root to: "landing#index"
end
