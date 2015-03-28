require 'time_difference'

module OmertaLogger
  class User < ActiveRecord::Base
    include ActiveModel::Dirty

    before_save do |u|
      save_rank_history if u.rank_changed?
      save_family_history if u.family_id_changed? || u.family_role_changed?
      save_name_history if !u.new_record? && u.name_changed? && !u.name_was.nil?
      save_revive if u.alive_changed? && !u.alive_was.nil? && !u.alive_was && u.alive
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
      version_time = TimeDifference.between(first_seen, death_date || version.last_version_update.generated || Time.now)
      # limit to 100.0 for users on their first login cycle
      [((online_time_seconds / version_time.in_seconds) * 100), 100.0].min
    end

    # @return [OmertaLogger::UserOnlineTime]
    def last_user_online_time
      user_online_times.order('end DESC').first
    end
  end
end
