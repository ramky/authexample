AuthexampleWebapp::Application.routes.draw do
  post :registrations, to: 'registrations#create', as: :register
end
