Rails.application.routes.draw do
  resources :students
  resources :teachers do
    resources :courses do
      resources :students
    end
  end
  resources :courses do
    resources :students
  end
  get 'welcome/index'
  root 'welcome#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
