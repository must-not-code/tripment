Rails.application.routes.draw do
  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      match '/procedures', to: 'procedures#index', via: :get
    end
  end
end
