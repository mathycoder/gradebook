Rails.application.routes.draw do

  get '/classes/redirect', to: "klasses#redirect", as: "klass_redirect"

  resources :klasses, :path => 'classes'
  resources :teachers
  get '/signup', to: "teachers#new"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :klasses, :path => 'classes' do
    get '/add_students', to: "klasses#add_students"
  end

  get '/classes/:klass_id/students/redirect', to: "students#redirect", as: "student_redirect"


  resources :klasses, :path => 'classes' do
    resources :students, only: [:index, :update, :show]
  end


  resources :klasses, :path => 'classes' do
    resources :assignments
  end

  get '/classes/:klass_id/learning_targets/redirect', to: "learning_targets#redirect", as: "lt_redirect"

  resources :klasses, :path => 'classes' do
    resources :learning_targets, :path => 'lts'
  end

  resources :standards
end
