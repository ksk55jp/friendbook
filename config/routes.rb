Rails.application.routes.draw do

  devise_for :users
  #
  resources :topics, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    collection do
      post :confirm
    end
  end

  ## Routing for top screen
  root 'top#index'
end
