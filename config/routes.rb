Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :pokemons do
    resources :rentals, only: [:create]
  end
  resources :rentals do # we don't actually want any rentals routes, we just want to nest reviews inside rentals
    resources :reviews, only [:new, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
