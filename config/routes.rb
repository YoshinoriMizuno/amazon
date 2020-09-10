Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  root 'amazon_com#index'
  resources :amazon_com, only: [:new, :create, :edit, :update, :show, :destroy]

  post 'amazon_com/:id/user_product_create' => 'amazon_com#user_product_create', as: 'amazon_com_user_product_create'
  delete 'amazon_com/:id/user_product_delete' => 'amazon_com#user_product_delete', as: 'amazon_com_user_product_delete'
  get 'amazon_com/:id/user_product_show' => 'amazon_com#user_product_show', as: 'amazon_com_user_product_show'
  delete 'amazon_com/:id/user_product_show_delete' => 'amazon_com#user_product_show_delete', as: 'amazon_com_user_product_show_delete'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
