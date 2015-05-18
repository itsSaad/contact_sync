
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      resources :users, only: [] do
        post :sync_contacts
        get :match_contacts
      end
    end
  end
