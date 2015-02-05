require_dependency 'omerta_logger/application_controller'

module OmertaLogger
  class UsersController < ApplicationController
    before_action :set_domain
    before_action :set_version

    def with_default_includes(finder)
      finder.includes(
          { family: :family_name_histories }, :version, :user_name_histories, :user_rank_histories, :user_revives
      )
    end

    def set_domain
      @domain = Domain.find_by!(name: params[:domain_domain])
    end

    def set_version
      @version = @domain.versions.find_by!(version: params[:version_version])
    end

    def index
      @users = with_default_includes(@version.users).all
    end

    def show
      if params[:id_or_name].to_i.zero?
        @user = with_default_includes(@version.users).find_by!(name: params[:id_or_name])
      else
        @user = with_default_includes(@version.users).find_by!(ext_user_id: params[:id_or_name])
      end
    end
  end
end
