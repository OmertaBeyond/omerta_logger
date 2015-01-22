require_dependency 'omerta_logger/application_controller'

module OmertaLogger
  class FamiliesController < ApplicationController
    before_filter :set_domain
    before_filter :set_version

    def set_domain
      @domain = Domain.find_by!(name: params[:domain_domain])
    end

    def set_version
      @version = @domain.versions.find_by!(version: params[:version_version])
    end

    def index
      @families = @version.families.all
    end

    def show
      if params[:id_or_name].to_i.zero?
        @family = @version.families.find_by!(name: params[:id_or_name])
      else
        @family = @version.families.find_by!(ext_family_id: params[:id_or_name])
      end
    end
  end
end
