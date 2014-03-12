ContentPlanner::Application.routes.draw do
  resources :contents

  root to: "home#index"

  resources :content_plans do
    get 'versions', on: :member
  end

  resources :tasks

  resources :comments

  resources :users

  resources :tags

  get "dashboard_data", to: "home#dashboard_data"
  get "chart", to: "home#chart"

  get "/healthcheck" => proc { [200, {}, ["OK"]] }

end
