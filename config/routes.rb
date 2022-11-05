Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      delete '/logout', to: 'sessions#destroy'
      get '/logged_in', to: 'sessions#is_logged_in?'
      post '/login', to: "sessions#create"

      post '/users', to: 'users#create'
      get '/users/:uuid', to: 'users#show'
      patch '/users/:uuid', to: 'users#update'
      delete '/users/:uuid', to: 'users#destroy'
     

      post '/recipes', to: 'recipes#create'
      get '/recipes/:uuid', to: 'recipes#show'
      patch '/recipes/:uuid', to: 'recipes#update'
      delete '/recipes/:uuid', to: 'recipes#destroy'
      get '/recipes', to: 'recipes#index' 
      get '/users/:uuid/recipes', to: 'recipes#user_recipes'
    end
  end
end
