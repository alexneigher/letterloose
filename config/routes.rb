Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'categories#index'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :categories, only: :show

  get :play_random, to: "titles#random"

  resource :search, only: :new

  resources :titles do
    resources :tweaks do
      resources :descriptions do
        put :upvote
      end
    end
  end

  resources :descriptions, only: :index

  resources :daily_wit_stops

  resources :users do
    resources :descriptions, only: :index, controller: 'users/descriptions'
    resource :email_preferences
  end

  resources :likes


  namespace :public do
    get 'email_preferences/:id', to: 'email_preferences#update', as: 'email_preferences'
  end


  get :privacy_policy, controller: 'static_pages'
  get :terms_of_use, controller: 'static_pages'

end
