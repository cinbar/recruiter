Recruiter::Application.routes.draw do
  devise_for :users
  root :to => "home#index"
  resources :jobs, only: [:create, :new, :index, :show, :edit, :update]
  namespace "api" do
    resources :jobs, only: [:create]
    resources :users, only: [:create, :show, :update, :destroy]
  end
end
