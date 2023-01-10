Rails.application.routes.draw do
  resources :sent_mails, path: 'mails'
  
  get 'users/sent_mails' => 'users#sent_mails'
  resources :users

  post 'users/login' => 'users#login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
