TransitionReview::Application.routes.draw do
  resources :content_plans

  resources :source_urls

  resources :users

  resources :tags

  devise_for :users, controllers: {registrations: "registrations"}

  root to: "home#index"
end