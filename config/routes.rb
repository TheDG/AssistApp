Rails.application.routes.draw do

  root 'welcome#index'

  resources :students
  devise_for :teachers
  resources :teachers
  resources :courses


  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'Teacher', at: 'auth'
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
