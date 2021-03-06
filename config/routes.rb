Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :tweets do
    member do
      put 'like', to: "tweets#like"
      put 'unlike', to: "tweets#unlike"
    end
  end
  root 'tweets#index'
  get '/profile/:id' => 'tweets#profile', as: 'profile'
  post '/following/:id' => 'following#create', as: 'follow'
  delete 'following/:id' => 'following#destroy', as: 'unfollow'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
