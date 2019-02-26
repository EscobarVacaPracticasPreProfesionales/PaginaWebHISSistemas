Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/main_page/index')
  get 'main_page/contactus'
  get 'main_page/references'
  get 'main_page/index'
  get 'main_page/search'
  get 'main_page/services'
  get 'main_page/us'

end
