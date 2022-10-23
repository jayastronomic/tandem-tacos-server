Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %w(create destroy update show)
      resources :recipes, only: %w(create destroy update show)
    end
  end
end
