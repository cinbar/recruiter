Recruiter::Application.routes.draw do
  root :to => "home#index"
  namespace :users do
    resources :sessions, only: [:new, :create]
  end
  get  "validate" => "users/sessions#validate"
  post "authorize" => "users/sessions#authorize"
  match "identify" => "users/sessions#identify", via: [:get, :post]
  
  resources :jobs, only: [:create, :new, :index, :show, :edit, :update]
  namespace "api" do
    resources :jobs, only: [:create]
    resources :users, only: [:create, :show, :update, :destroy]
  end
end
