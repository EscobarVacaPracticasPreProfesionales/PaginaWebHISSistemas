Rails.application.routes.draw do
  put 'services/destroy_picture'
  put 'references/destroy_picture'
  put 'contacts/check_contact'
  resources :contacts
  resources :articles do
    member do
      put :destroy_picture
    end
  end
  resources :references
  resources :services
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :home, only: [:index]
  resources :us, only: [:index]
  resources :search, only: [:index] do
    member do
      get :search_articles
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/home')
end
