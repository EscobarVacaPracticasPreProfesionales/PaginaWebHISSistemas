Rails.application.routes.draw do
  put 'services/destroy_picture'
  put 'references/destroy_picture'
  put 'articles/destroy_picture'
  post 'services/validate_before'
  resources :contacts
  resources :articles
  resources :references
  resources :services
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :home, only: [:index]
  resources :us, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/home')
  get 'main_page/contactus'
  get 'main_page/references'
  get 'main_page/index'
  get 'main_page/search'
  get 'main_page/news'
  get 'main_page/services'
  get 'main_page/us'
  get 'admin/contactus'
  get 'admin/references'
  get 'admin/index'
  get 'admin/search'
  get 'admin/news'
  get 'admin/services'
  get 'admin/us'
  get 'admin/newsTemplate'

end
