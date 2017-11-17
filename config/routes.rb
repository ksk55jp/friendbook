Rails.application.routes.draw do


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :conversations do
    resources :messages
  end

  resources :topics do
    resources :comments
    post :confirm, on: :collection
  end

  ## Routing for top screen
  root 'top#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, only: [:index]


  resources :relationships, only: [:create, :destroy]


end
