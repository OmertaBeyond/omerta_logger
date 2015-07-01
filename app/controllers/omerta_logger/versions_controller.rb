require_dependency 'omerta_logger/application_controller'

module OmertaLogger
  class VersionsController < ApplicationController
    before_action :set_domain

    def with_default_includes(finder)
      finder.includes(
        families: [ :family_name_histories, :users ],
        users: [ :family, :version, :user_name_histories, :user_rank_histories, :user_revives ]
      )
    end

    def index
      @versions = with_default_includes(@domain.versions).all
    end

    def show
      @version = with_default_includes(@domain.versions).find_by!(version: params[:version])
    end
  end
end
