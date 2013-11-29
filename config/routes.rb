ContentPlanner::Application.routes.draw do
  resources :contents

  root to: "home#index"

  resources :content_plans do
    resources :tasks
    get 'versions', on: :member
  end

  resources :comments

  resources :source_urls

  resources :users

  resources :tags

  get "needs", to: "needs#index"

  get "/healthcheck" => proc { [200, {}, ["OK"]] }

end