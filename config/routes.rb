TransitionReview::Application.routes.draw do
  resources :source_urls

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end