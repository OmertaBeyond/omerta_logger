module OmertaLogger
  class ApplicationController < ActionController::Base
    def set_domain
      @domain = Domain.find_by!(name: params[:domain_domain])
    end

    def set_version
      @version = @domain.versions.find_by!(version: params[:version_version])
    end
  end
end
