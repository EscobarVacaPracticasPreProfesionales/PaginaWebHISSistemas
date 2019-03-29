Rails.application.routes.draw do
  resources :contacts do
    collection do
      get :check_contact
    end
  end

  resources :articles do
    collection do
      put :destroy_picture
    end
  end

  resources :references do
    collection do
      put :destroy_picture
    end
  end

  resources :services do
    collection do
      put :destroy_picture
    end
  end

  resources :search, only: [:index] do
    collection do
      get :search_articles
    end
  end

  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :home, only: [:index]
  resources :us, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/home')
end
