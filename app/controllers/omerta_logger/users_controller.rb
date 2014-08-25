require_dependency "omerta_logger/application_controller"

module OmertaLogger
  class UsersController < ApplicationController
    before_filter :set_domain
    before_filter :set_version

    def set_domain
      @domain = Domain.find_by!(name: params[:domain_domain])
    end

    def set_version
      @version = @domain.versions.find_by!(version: params[:version_version])
    end

    def index
      @users = @version.users.eager_load(:family).all
    end

    def show
      if params[:id_or_name].to_i.zero?
        @user = @version.users.eager_load(:family).find_by!(name: params[:id_or_name])
      else
        @user = @version.users.eager_load(:family).find_by!(ext_user_id: params[:id_or_name])
      end
    end
  end
end
