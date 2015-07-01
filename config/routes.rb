OmertaLogger::Engine.routes.draw do
  resources :domains, :only => [ :index, :show ], param: :domain, :defaults => { :format => 'json' } do
    resources :versions, :only => [ :index, :show ], param: :version, :version => /((\d\.?)+?|latest)/, :defaults => { :format => 'json' } do
      resources :users, :only => [ :index, :show ], param: :id_or_name, :defaults => { :format => 'json' }
      resources :families, :only => [ :index, :show ], param: :id_or_name, :defaults => { :format => 'json' }
    end
  end
end
