TransitionReview::Application.routes.draw do
  root to: "home#index"

  devise_for :users, controllers: {registrations: "registrations"}

  resources :content_plans do
    resources :tasks
  end

  resources :source_urls

  resources :users

  resources :tags

end