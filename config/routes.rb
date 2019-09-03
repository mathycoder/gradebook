Rails.application.routes.draw do

  #student experience routes
  get '/studentklasses', to: "student_klasses#index", as: "s_klasses"
  get '/studentklasses/:id', to: "student_klasses#show", as: "s_klass"

  #teacher experience routes
  get '/students/new/csv', to: "students#csv"
  post '/students/new/csv', to: "students#csv_upload"

  resources :students, only: [:new, :create, :edit, :update, :destroy]

  get '/classes/redirect', to: "klasses#redirect", as: "klass_redirect"

  resources :klasses, :path => 'classes'

  get '/busyteacher', to: "teachers#busy"

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

  #omniauth
  get '/auth/facebook/callback' => 'sessions#create'
  root 'sessions#new'
end
