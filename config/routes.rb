ContentPlanner::Application.routes.draw do
  resources :contents

  root to: "home#index"

  resources :status_transitions, path: 'velocity'

  resources :content_plans do
    resources :tasks

    get 'versions', on: :member
  end

  resources :comments

  resources :users

  resources :tags

  get "needs", to: "needs#index"

  get "dashboard_data", to: "home#dashboard_data"

  get "/healthcheck" => proc { [200, {}, ["OK"]] }

end
