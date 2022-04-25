Rails.application.routes.draw do
  root "contacts#index"
  resources :contacts do
    member do
      post :edit
    end
  end
end
