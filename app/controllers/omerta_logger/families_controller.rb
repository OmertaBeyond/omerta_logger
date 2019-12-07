require_dependency 'omerta_logger/application_controller'

module OmertaLogger
  class FamiliesController < ApplicationController
    before_action :set_domain
    before_action :set_version

    def with_default_includes(finder)
      finder.includes(
        { users: %i[version user_name_histories user_rank_histories user_revives] },
        :family_name_histories
      )
    end

    def index
      @families = with_default_includes(@version.families).all
    end

    def show
      @family = if params[:id_or_name].to_i.zero?
                  with_default_includes(@version.families).order('first_seen DESC').find_by!(name: params[:id_or_name])
                else
                  with_default_includes(@version.families).find_by!(ext_family_id: params[:id_or_name])
                end
    end

    def ranks
      families = @version.families
                     .includes(:users, :family_name_histories)
                     .where(alive: true)
                     .where(omerta_logger_users: { alive: true })
                     .order('position')
      @rank_template = {}
      User.ranks.each do |r|
        @rank_template[r.first] = 0
      end
      @stats = []
      families.each do |f|
        @stats << get_rank_stat(f)
      end
      famless_users = @version.users.where(family: nil).where(alive: true)
      famless_family = OpenStruct.new({
          ext_family_id: nil,
          name: 'No family',
          family_name_histories: [],
          worth: nil,
          rank: nil,
          position: nil,
          users: famless_users,
      })
      @stats << get_rank_stat(famless_family)
    end

    private
    def get_rank_stat(family)
      ranks = @rank_template.clone
      highrank_points = 0
      family.users.each do |u|
        ranks[u.rank] += 1
        highrank_points += u.highrank_points
      end
      cur_stat = OpenStruct.new({
                                    :id => family.ext_family_id,
                                    :name => family.name,
                                    :previous_names => family.family_name_histories.map{ |n| n.name },
                                    :worth => family.worth,
                                    :rank => family.rank,
                                    :position => family.position,
                                    :user_ranks => ranks,
                                    :highrank_points => highrank_points,
                                })
      @stats << cur_stat
    end
  end
end
