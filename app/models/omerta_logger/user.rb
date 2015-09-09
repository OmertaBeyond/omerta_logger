# == Schema Information
#
# Table name: omerta_logger_users
#
#  id                  :integer          not null, primary key
#  ext_user_id         :integer
#  version_id          :integer
#  name                :string
#  gender              :integer
#  rank                :integer
#  honor_points        :integer
#  level               :integer
#  donor               :boolean
#  first_seen          :datetime
#  last_seen           :datetime
#  family_id           :integer
#  family_role         :integer
#  alive               :boolean
#  akill               :boolean
#  death_date          :datetime
#  death_family        :string
#  died_without_family :boolean
#  rip_topic           :integer
#  created_at          :datetime
#  updated_at          :datetime
#  online_time_seconds :integer          default(0)
#

require 'time_difference'

module OmertaLogger
  class User < ActiveRecord::Base
    include ActiveModel::Dirty

    before_save do |u|
      save_rank_history if OmertaLogger.config.user_rank_history && u.rank_changed?
      save_family_history if OmertaLogger.config.user_family_history && (
        u.family_id_changed? || u.family_role_changed?
      )
      save_name_history if OmertaLogger.config.user_name_history && !u.new_record? && u.name_changed? &&
                           !u.name_was.nil?
      save_revive if OmertaLogger.config.user_revive && u.alive_changed? && !u.alive_was.nil? && !u.alive_was && u.alive
    end

    has_many :user_rank_histories
    has_many :user_family_histories
    has_many :user_online_times
    has_many :user_name_histories
    has_many :user_revives
    has_many :hitlistings, class_name: 'Hitlist', foreign_key: 'target_id'
    has_many :added_hitlistings, class_name: 'Hitlist', foreign_key: 'hitlister_id'
    has_many :casinos
    has_many :business_objects
    has_many :bullet_factories
    belongs_to :family
    belongs_to :version
    enum gender: [ :male, :female ]
    enum rank: [ :empty_suit, :delivery_boy, :delivery_girl, :picciotto, :shoplifter,
                 :pickpocket, :thief, :associate, :mobster, :soldier, :swindler,
                 :assassin, :local_chief, :chief, :bruglione, :capodecina,
                 :godfather, :first_lady ]
    enum level: [ :player, :translation_crew, :user_group ]
    enum family_role: [ :member, :capo, :sotto, :consig, :don ]

    def save_rank_history
      user_rank_histories.create(rank: rank, date: last_seen)
    end

    def save_family_history
      user_family_histories.create(family: family, family_role: family_role,
                                   date: last_seen)
    end

    def save_name_history
      user_name_histories.create(name: name_was, date: last_seen)
    end

    def save_revive
      user_revives.create(date: last_seen)
    end

    def online_percentage
      return nil if first_seen.nil?
      # users can now pre-register before versions start. for those users, the period looked at for online_percentage
      # should be based on the version start date instead of their registration date
      diff_start = [first_seen, version.start].max
      # Time.zone.now is necessary to stay BC compatible with data from before version_update was introduced
      diff_end = death_date || version.last_version_update.generated || Time.zone.now
      version_time = TimeDifference.between(diff_start, diff_end)
      on_perc = ((online_time_seconds / version_time.in_seconds) * 100.0)
      on_perc = 0.0 if on_perc.nan?
      # limit to 100.0 for users on their first login cycle
      [on_perc, 100.0].min
    end

    # @return [OmertaLogger::UserOnlineTime]
    def last_user_online_time
      user_online_times.order('end DESC').first
    end

    def rank_short
      rank_abbr = %w(ES DB DG PIC SHO PP TH ASO MOB SOL SWI ASA LC CHF BR CDC GF FL)
      rank_abbr[User.ranks[rank]]
    end
  end
end
