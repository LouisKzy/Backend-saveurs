Rails.application.routes.draw do
  resources :order_items, only: [:index, :show, :create]
  resources :orders, only: [:index, :show]
  
  get '/cart', to: 'carts#show'
  resources :cart_products, only: [:create, :destroy, :update]
  

  resources :products do
    resources :product_images, only: [:create, :update, :destroy]
  end
  
  devise_for :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

  resources :users, only: [:show, :update, :destroy] do
    get 'edit', on: :member
    get 'member-data', on: :collection, to: 'members#show'
  end

  scope '/checkout' do
    post '/create', to: 'checkout#create', as: 'checkout_create'
    get '/success', to: 'checkout#success', as: 'checkout_success'
    get '/cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end
end
