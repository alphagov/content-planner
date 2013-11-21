ContentPlanner::Application.routes.draw do
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

end