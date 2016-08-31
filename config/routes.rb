Rails.application.routes.draw do  
  use_doorkeeper
  root to: "application#index"  
  post 'auth/steam/callback' => 'api/v1/sessions#auth_callback'
      
  namespace :api do
    namespace :v1 do
      root to: "base#index"
      get '/users/me', to: 'users#me'
      get '/sign', to: "base#sign"
      resources :users
      post '/upload', to: "users#upload"
      resources :attendances
      resources :projects
    end
  end
end
