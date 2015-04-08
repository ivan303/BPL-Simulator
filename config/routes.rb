Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'choose_team#show'

  get '/choose_team', to: 'choose_team#show' #, as: ''
  post '/choose_team', to: 'choose_team#create'
  delete '/choose_team', to: 'choose_team#destroy'

  get '/team_management', to: 'team_management#show'

  post '/simulation', to: 'simulation#create'
  get '/simulation', to: 'simulation#show'

  get '/league_result', to: 'league_result#show'

  resources :clubs, only: [:show]

  resources :players, only: [:index, :update, :create, :new]

  get '/search', to: 'search#show'

  get '/transfers', to: 'transfers#index'
end
