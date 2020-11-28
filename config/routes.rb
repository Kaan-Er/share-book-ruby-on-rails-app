Rails.application.routes.draw do
  get 'users/index'
  match '/users/:id', to: 'users#index', via: 'get'
  match '/comments/:id', to: 'comments#new', via: 'get'
  match '/users/:id/comment', to: 'users#show', via: 'get'
  match '/books/:id/comments/:id/approve', to: 'comments#approve', via: 'get'
  match '/books/:id/favorite', to: 'books#favorite', via: 'get'
  match '/books/:id/trades/:id/approve', to: 'trades#approve', via: 'get'
  match '/books/:id/trades/:id/deny', to: 'trades#deny', via: 'get'
  devise_for :users, :path_prefix => 'd'
  resources :users, :only =>[:show]
  root 'welcome#index'

  resources :dashboard
  resources :comments

  resources :books do
    resources :comments
    resources :trades
  end
end
