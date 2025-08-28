Rails.application.routes.draw do
  get '/cubes', to: 'cubes#index'
  get '/cubes/:id', to: 'cubes#show'
  post '/cubes/create', to: 'cubes#create'
  put '/cubes/rotate', to: 'cubes#rotate'
end
