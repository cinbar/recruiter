Recruiter::Application.routes.draw do
  root :to => "home#index"
  devise_scope :user do
    devise_for :users, :controllers => {:sessions => "users/sessions"}
    get  "validate" => "users/sessions#validate"
    post "authorize" => "users/sessions#authorize"
  end
  resources :jobs, only: [:create, :new, :index, :show, :edit, :update]
  namespace "api" do
    resources :jobs, only: [:create]
    resources :users, only: [:create, :show, :update, :destroy]
  end
end
