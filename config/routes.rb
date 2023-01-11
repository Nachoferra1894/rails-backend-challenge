Rails.application.routes.draw do
  get 'mails/all' => 'sent_mails#all_mails'
  resources :sent_mails, path: 'mails', except: [:edit]

  
  get 'users/sent_mails' => 'users#sent_mails'
  get 'users/stats' => 'users#stats'
  post 'users/login' => 'users#login'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
