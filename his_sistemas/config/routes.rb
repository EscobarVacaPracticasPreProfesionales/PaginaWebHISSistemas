Rails.application.routes.draw do
  put 'services/destroy_picture'
  put 'references/destroy_picture'
  put 'contacts/check_contact'
  put 'articles/destroy_picture'
  resources :contacts
  resources :articles
  resources :references
  resources :services
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :home, only: [:index]
  resources :us, only: [:index]
  resources :search, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/home')
end
