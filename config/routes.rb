Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers
  resources :product_models, only: [:index, :show, :new, :create]
  resources :orders, only: [:new, :create, :show, :index, :edit, :update] do
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
  end
end
