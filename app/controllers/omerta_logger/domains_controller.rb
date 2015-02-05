require_dependency 'omerta_logger/application_controller'

module OmertaLogger
  class DomainsController < ApplicationController
    def with_default_includes(finder)
      finder.includes(
        versions: [
          families: [ :family_name_histories, :users ],
          users: [ :family, :version, :user_name_histories, :user_rank_histories, :user_revives ]
        ]
      )
    end

    def index
      @domains = with_default_includes(Domain.all)
    end

    def show
      @domain = with_default_includes(Domain).find_by(name: params[:domain])
    end
  end
end
