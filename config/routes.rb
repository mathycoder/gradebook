Rails.application.routes.draw do
  resources :klasses, :path => 'classes'
  resources :teachers
  get '/signup', to: "teachers#new"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :klasses, :path => 'classes' do
    get '/add_students', to: "klasses#add_students"
  end

  resources :klasses, :path => 'classes' do
    resources :students, only: [:index, :update]
  end

  resources :klasses, :path => 'classes' do
    resources :assignments
  end


end
