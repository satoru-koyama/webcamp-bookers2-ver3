Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings', to: 'relationships#followings', as: 'followings'
    get 'followers', to: 'relationships#followers', as: 'followers'
    # relationships は中間テーブルなので、usersモデルにネストさせる。
    # URLからparamsで:user_idと:idを受け取ることができる。
  end

  resources :books do
    resources :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

end