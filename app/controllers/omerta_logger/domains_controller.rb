require_dependency 'omerta_logger/application_controller'

module OmertaLogger
  class DomainsController < ApplicationController
    def index
      @domains = Domain.all
    end

    def show
      @domain = Domain.find_by(name: params[:domain])
    end
  end
end
