Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users, only: [:index, :show, :create] do
    member do
      get :saves
    end
  end
  
  resources :bookmarks, only: [:new, :create, :destroy]
  resources :keeps, only: [:create, :destroy]
end
