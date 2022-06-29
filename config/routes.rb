Rails.application.routes.draw do
  # POST to user_exams is the specific endpoint for the challenge
  resources :user_exams
  resources :exam_windows
  resources :exams
  resources :colleges
  resources :users
end
