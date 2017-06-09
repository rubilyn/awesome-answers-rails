Rails.application.routes.draw do

  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]

  namespace :admin do
    resources :users, only: :index
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :users, only: [:new, :create] do
    get 'liked_questions', to: 'questions#index'
  end

  resources :questions do
    resources :likes, only: [:create, :destroy]
    resources :answers, only: [:create, :destroy]
    resources :votes, only: [:create, :update, :destroy]

  end

  resources :answers, only: [] do
    resources :likes, only: [:create, :destroy]
  end

  get('/contact', { to: 'welcome#contact' })
  post('/contact_submit', { to: 'welcome#submit' })
  get '/', to: 'welcome#index', as: 'home'

end
