require_dependency 'omerta_logger/application_controller'

module OmertaLogger
  class FamiliesController < ApplicationController
    before_action :set_domain
    before_action :set_version

    def with_default_includes(finder)
      finder.includes(
        { users: [ :version, :user_name_histories, :user_rank_histories, :user_revives ] },
        :family_name_histories
      )
    end

    def index
      @families = with_default_includes(@version.families).all
    end

    def show
      if params[:id_or_name].to_i.zero?
        @family = with_default_includes(@version.families).find_by!(name: params[:id_or_name])
      else
        @family = with_default_includes(@version.families).find_by!(ext_family_id: params[:id_or_name])
      end
    end
  end
end
