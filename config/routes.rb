Rails.application.routes.draw do
  
  # Home
  root to: "home#home"
  # Dashboard
  get 'dashboard', to: "home#dashboard"
  ### Search
  get 'search', to: 'search#es_search'
  
  ### Artists
  get "artists/:id", to: "artists#show", as: :artist
  get "artists/artist_labels/:artist_id", to: 'artists#artist_labels_list'
  
  ### Releases
  get "releases/:id", to: "releases#show", as: :release
  
  ### Release Tracks
  get "release_tracks/:id", to: 'release_tracks#show', as: :release_track
  
  ### Label
  get "labels/:id", to: 'labels#show', as: :label
  
  ### Queues
  get "queues/scrub", to: 'queue_tracks#scrub', as: :scrub
  get "queues/listen", to: 'queue_tracks#scrub', as: :listen 
  get "queues/weekly", to: 'queue_tracks#scrub', as: :weekly
  post 'queues/enqueue', to: 'queue_tracks#enqueue', as: :enqueue
  
  devise_for :users
end
