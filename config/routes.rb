AuthexampleWebapp::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :registrations, to: 'registrations#create', as: :register
      #resources :sessions, only: [:create, :destroy]
      post :sessions, to: 'sessions#create'
      delete :sessions, to: 'sessions#destroy'
      resources :tasks, only: [:create, :index]
      get 'login', to: 'sessions#new'
      get 'logout', to: 'sessions#destroy'
      put 'tasks/:id/complete', to: 'tasks#complete'
      put 'tasks/:id/open', to: 'tasks#open'
    end
  end
end
