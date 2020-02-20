Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'search/items', to: 'search#items'
  get 'search/age', to: 'search#age'
  post 'create/event', to: 'events#create'
  get 'get_all_records', to: 'events#all_records'
end
