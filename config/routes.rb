Rails.application.routes.draw do

  root 'welcome#index'
  get 'welcome/home'


  resources :students
  devise_for :teachers
  resources :courses
  resources :teachers
  resources :courses do
    resources :students
  end
  resources :assistances, only: [:index]

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
      scope 'course_assistance' do
        get '/:id/:date' => 'content#daily_course_assistance'
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
