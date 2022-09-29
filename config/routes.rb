Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'articles#index'
  # get 'welcome/index'
  # get 'articles', to: "articles#index"
  # get 'articles/new', to: "articles#new"
  # get "articles/:id", to: "articles#show"
  # get "articles/:id/edit", to: "articles#edit"
  # delete "articles/:id/destroy", to: "articles#delete"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :articles do
    resources :comments
  end
  # resources :users
  # root 'home#index'
end