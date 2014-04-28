ContentPlanner::Application.routes.draw do
  resources :contents

  root to: "home#index"

  resources :content_plans do
    member do
      get 'versions'
      get :xls_export
    end
  end

  resources :tasks

  resources :comments do
    member do
      post :reply
    end
  end

  resources :users

  resources :tags, only: [:index, :new, :create, :edit, :update, :destroy]

  get "dashboard_data", to: "home#dashboard_data"
  get "chart", to: "home#chart"

  get "/healthcheck" => proc { [200, {}, ["OK"]] }

end
