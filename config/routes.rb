Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pins#index"

  get '/users', to: "pins#index"

  resources :pins do
    member do
      put "like", to: "pins#like"
      put "unlike", to: "pins#unlike"
    end
  end
end
