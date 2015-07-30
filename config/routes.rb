Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'tonight', to: 'tonight#show'
    end
  end

end
