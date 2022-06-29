Rails.application.routes.draw do
  resources :user_exams
  resources :exam_windows
  resources :exams
  resources :colleges
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
