Rails.application.routes.draw do
  root "contacts#index"
  resources :contacts do
    member do
      post :edit
    end
    collection do
      post :search
    end
  end
end
