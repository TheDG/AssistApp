Rails.application.routes.draw do
  devise_for :teachers
  resources :students
  resources :teachers
  resources :courses
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
