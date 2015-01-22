require_dependency 'omerta_logger/application_controller'

module OmertaLogger
  class VersionsController < ApplicationController
    before_filter :set_domain

    def set_domain
      @domain = Domain.find_by!(name: params[:domain_domain])
    end

    def index
      logger.debug params
      @versions = @domain.versions.all
    end

    def show
      @version = @domain.versions.find_by!(version: params[:version])
    end
  end
end
