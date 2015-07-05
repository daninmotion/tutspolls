Tutspolls::Application.routes.draw do
 
  devise_for :users
  resources :polls do
  	resources :questions
  	resources :replies, only: [ :new, :create ]
  end #/polls/1/questions

  root 'polls#index'
end
