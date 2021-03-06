Rails.application.routes.draw do
  devise_for :speakers, controllers: {registrations: "registrations"}

  root "events#show"

  get "coc"      => "events#coc"
  get "sponsor"  => "events#sponsor"
  get "schedule" => "events#schedule"
  get "submit"   => "accounts/sessions#index"

  resources :metrics, only: [:index]
  resources :submissions
  resources :scholarship_applications, only: [:index, :new, :create] do
    collection do
      get "thanks"
    end
  end

  resources :sessions, only: [:index, :show]

  resources :speakers, only: nil do
    collection do
      get "talks"
    end
  end

  resources :events, only: [:index, :show] do
    resources :sessions, only: [:index, :show]
    resources :metrics, only: [:index]
    member do
      get "schedule"
    end
  end

  namespace "accounts" do
    resources :sessions
  end

  namespace "selection" do
    resources :sessions, only: :index do
      resources :votes, only: [:create, :destroy]
    end
  end

  namespace "admin" do
    resources :sessions, only: :index do
      member do
        post "schedule"
      end
      collection do
        get "export"
        post "promote_session"
        get "make_schedule"
      end
    end
    resources :speakers do
      collection do
        get "list_users"
        get "selectors"
      end
    end
    resources :events do
      member do
        get "duplicate"
      end
    end
    resources :scholarship_applications, only: :index
    resources :speakers, only: :index do
      member do
        post "make_selector"
        post "make_admin"
      end
    end
  end

  scope "api", defaults: {format: :json} do
    resources :venues, only: [:index, :show]

    resources :events, only: [:index, :show] do
      collection do
        get "latest"
      end
      member do
        resources :speakers, :sponsors, :sponsor_levels, :venues,
          :rooms, :organizers, :sessions, :slots, only: [:index, :show]
      end
    end

    resources :sessions, only: [:index, :show] do
      member do
        resources :feedbacks, only: :create
      end
    end
  end
end
