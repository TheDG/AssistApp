# Rails router
Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/home'

  resources :students do
    collection do
      get 'own_index'
    end
  end
  devise_for :teachers

  resources :courses do
    collection do
      get 'own_index'
    end
    member do
      get :all_qr
    end
    resources :students
    resources :assistances, only: [:index]
  end

  resources :teachers do
    collection {post :import}
  end

  resources :students do
    collection { post :import }
    member do
      get :generate_qr
    end
  end

  resources :teachers do
    resources :courses do
      resources :students
    end
  end

  resources :assistances, only: [:index] do
    member do
      put :change_assist
    end
  end

  get 'welcome/index'

  get 'admin/display'
  get 'admin/add_teacher'
  get 'admin/add_student'
  get 'admin/add_student2'
  post 'admin/add_student3'
  get 'admin/student_courses_index'

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'Teacher', at: 'auth'
      get 'course_students' => 'content#course_students'
      post 'record_assistance' => 'content#record_assistance'
      delete 'assistance' => 'content#destroy_assistance'
      delete 'all_assistance' => 'content#destroy_all_assistance'
      scope 'course_assistance' do
        get '/:id/:date' => 'content#daily_course_assistance'
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
