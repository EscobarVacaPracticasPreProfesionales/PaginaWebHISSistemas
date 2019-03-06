Rails.application.routes.draw do
  get 'us/index'
  resources :home, only: [:index]

  root to: redirect('/home')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
