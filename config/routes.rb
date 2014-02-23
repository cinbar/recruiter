Recruiter::Application.routes.draw do
  devise_for :users
  root :to => "home#index"
  resources :jobs, only: [:create, :new, :index, :show, :edit]
end
