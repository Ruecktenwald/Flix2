Rails.application.routes.draw do

  
  resources :genres
	get 'signup' => 'users#new'
	resource :session
  resources :users
  root "movies#index"
  resources :movies do
    resources :reviews
    resources :favorites
  end
end
