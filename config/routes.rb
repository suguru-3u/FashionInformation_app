Rails.application.routes.draw do

  namespace :users do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/new'
  end
  root to: 'users/homes#top'
# デバイスのURL
  devise_for :users, skip: :all
  devise_scope :user do
    get '/users/sign_in' => 'users/sessions#new', as: 'new_user_session'
    post '/users/sign_in' => 'users/sessions#create', as: 'user_session'
    delete '/users/sign_out' => 'users/sessions#destroy', as: 'destroy_user_session'
    get '/users/sign_up' => 'users/registrations#new', as: 'new_user_registration'
    get '/users/passwords/edit' => 'users/registrations#edit', as: 'password_edit_registrations'
    patch '/users/passwords/update' => 'users/registrations#update'
    post '/users/sign_up' => 'users/registrations#create', as: 'user_registration'
    get '/users/' => 'users/passwords#edit', as: 'edit_user_password'
    patch '/users/passwords' => 'users/passwords#update', as: 'user_password'
    get '/users/passwords/new' => 'users/passwords#new',as: 'user_forgot_password'
  end
# ユーザー側のURL
  namespace :users do
    get 'homes/top' => 'homes#top',as: '/'
    get 'homes/about' => 'homes#about'
    resource :users, only:[:show,:edit,:update]
    resources :posts do
      resources :comments, only: [:create,:destroy]
    end
  end


  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'

    authenticated :admin do
      delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
      get 'admins/password/edit' => 'admins/passwords#edit', as: 'edit_admin_password'
      patch 'admins/password' => 'admins/passwords#update', as: 'admin_password'
      get 'admins/passwords/new' => 'admins/password#new', as: 'admin_forgot_password'
    end
  end

  namespace :admins do
    resource :admins, only:[:show,:edit]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
