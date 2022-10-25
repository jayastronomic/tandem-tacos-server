Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/users', to: 'users#create'
      get '/users/:uuid', to: 'users#show'
      patch '/users/:uuid', to: 'users#update'
      delete '/users/:uuid', to: 'users#destroy'

      post '/recipes', to: 'recipes#create'
      get '/recipes/:uuid', to: 'recipes#show'
      patch '/recipes/:uuid', to: 'recipes#update'
      delete '/recipes/:uuid', to: 'recipes#destroy'
    end
  end
end
