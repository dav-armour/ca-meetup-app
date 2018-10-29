Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  root 'pages#home'
  get 'groups/search', to: 'groups#new'
  post 'groups/search', to: 'groups#search'
  resources :groups
  resources :events do
    post 'set_attendance', to: 'events#set_attendance', as: 'set_attendance'
    resources :ratings
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
