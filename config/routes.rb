Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] 

   #category分け
  get 'items/category1' => 'items#category1'
  get 'items/category2' => 'items#category2'
  get 'items/category3' => 'items#category3'
  get 'items/category4' => 'items#category4'
  get 'items/category5' => 'items#category5'
  root 'items#index'
  resources :items do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :hello do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  namespace :admin do
  resources :items, only: [:new]
  end
  


  
 


end
