Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :pokemons do
    resources :rentals, only: [:new, :create] do
      collection do
        get :success
      end
    end
  end
  resources :rentals, only: [] do # we don't actually want any rentals routes, we just want to nest reviews inside rentals
    resources :reviews, only: [:new, :create]
  end
  # this route is temporary, it's just for Wed's demo
  get '/history', to: 'pages#history'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

#  get '/pokemons/:pokemon_id/rentals/success', to: 'rentals#success'
