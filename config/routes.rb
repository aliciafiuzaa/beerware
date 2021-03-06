Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/search' => 'pages#search', :as => 'search_page'
  get '/map' => 'pages#map', :as => 'map_page'
  get '/landing' => 'pages#landing', :as => 'landing_page'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bars do
    member do
      get :map
      get :beer_menu
    end
  end

  resources :beers do

    member do
      post :drank # use link_to
      post :to_drink
      delete :unlist
      get :bar_list
    end

    resources :reviews, only: [ :new, :create, :edit, :update ]
  end

  resources :reviews, only: :destroy

  resources :users, only: [] do
    collection do
      get :profile
    end
  end
end
