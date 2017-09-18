Rails.application.routes.draw do
  #
  resources :topics, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    collection do
      post :confirm
    end
  end
end
