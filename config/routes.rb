Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do

      post '/auth/sign_up', to: 'authentication#sign_up'
      post '/auth/sign_in', to: 'authentication#sign_in'

      resources :projects do
        collection do
          get :index_projects_with_tasks
        end
      end
      resources :tasks

      match '/user/me' => 'users#me', via: :get
      match '/user/update_my_account' => 'users#update_my_account', via: :patch
      match '/user/destroy_my_account' => 'users#destroy_my_account', via: :delete

    end
  end
end
