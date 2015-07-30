Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'tonight', to: 'tonight#show'
      get 'tonight/archive', to: 'tonight#index'
    end
  end

end
