AuthexampleWebapp::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :registrations, to: 'registrations#create', as: :register
      resources :sessions, only: [:create, :destroy]
      get 'login', to: 'sessions#new'
      get 'logout', to: 'sessions#destroy'
    end
  end
end
