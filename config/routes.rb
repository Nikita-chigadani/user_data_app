Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get 'users', action: :getUsers, controller: :users
    post 'user', action: :addUser, controller: :users
    get 'show', action: :showUser, controller: :users
    put 'update', action: :updateUser, controller: :users
    delete 'delete', action: :deleteUser, controller: :users
    get 'search/:input', action: :search, controller: :users
  end
end
